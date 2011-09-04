# -*- coding: utf-8 -*-

class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]

  def index
    @services = current_user.services.all
  end
  
  def destroy
    @service = current_user.services.find(params[:id])
    @service.destroy
    
    redirect_to services_path
  end
  
  def create
    # 라우터에서 인자 받아옴
    params[:service] ? service_route = params[:service] : service_route = 'no service (invalid callback)'
    
    # omniauth 로부터 해시 받아옴
    omniauth = request.env["omniauth.auth"]
    
    #  해시와 인자가 있을 경우에만 
    if omniauth and params[:service]
      
      # map the returned hashes to our variables first - the hashes differ for every service
      if service_route == 'facebook'
        omniauth['extra']['user_hash']['email'] ? email =  omniauth['extra']['user_hash']['email'] : email = ''
        omniauth['extra']['user_hash']['name'] ? name =  omniauth['extra']['user_hash']['name'] : name = ''
        omniauth['extra']['user_hash']['id'] ?  uid =  omniauth['extra']['user_hash']['id'] : uid = ''
        omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
      elsif service_route == 'twitter'
        email = ''    # Twitter API never returns the email address
        omniauth['user_info']['name'] ? name =  omniauth['user_info']['name'] : name = ''
        omniauth['uid'] ?  uid =  omniauth['uid'] : uid = ''
        omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
      elsif service_route == 'google'
        omniauth['user_info']['email'] ? email =  omniauth['user_info']['email'] : email = ''
        omniauth['user_info']['name'] ? name =  omniauth['user_info']['name'] : name = ''
        omniauth['uid'] ? uid =  omniauth['uid'] : uid = ''
        omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
      else
        # we have an unrecognized service, just output the hash that has been returned
        render :text => omniauth.to_yaml
        #render :text => uid.to_s + " - " + name + " - " + email + " - " + provider
        return
      end
      
      
      # continue only if provider and uid exist
      if uid != '' and provider != ''
        
        # nobody can sign in twice, nobody can sign up while being signed in (this saves a lot of trouble)
        if !user_signed_in?
          
          # check if user has already signed in using this service provider and continue with sign in process if yes
          auth = Service.find_by_provider_and_uid(provider, uid)
          if auth
            flash[:notice] =  provider.capitalize + ' 을 통해 로그인 되었습니다.'
            sign_in_and_redirect(:user, auth.user)
          else
            # check if this user is already registered with this email address; get out if no email has been provided
            if email != ''
              # search for a user with this email address
              existinguser = User.find_by_email(email)
              if existinguser
                # map this new login method via a service provider to an existing account if the email address is the same
                existinguser.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
                flash[:notice] = provider.capitalize + '를 통한 로그인이 ' + existinguser.email + ' 에 추가되었습니다.'
                sign_in_and_redirect(:user, existinguser)
              else
                # let's create a new user: register this user and add this authentication method for this user
                name = name[0, 39] if name.length > 39             # otherwise our user validation will hit us
                
                # new user, set email, a random password and take the name from the authentication service
                user = User.new :email => email, :password => SecureRandom.hex(10), :fullname => name
                
                # add this authentication service to our new user
                user.services.build(:provider => provider, :uid => uid, :uname => name, :uemail => email)
                
                # do not send confirmation email, we directly save and confirm the new record
                user.skip_confirmation!
                user.save!
                user.confirm!
                
                # flash and sign in
                flash[:myinfo] = provider.capitalize + ' 를 통해 계정이 생성되었습니다. 프로필에 가서 상세정보를 추가해주세요.'
                sign_in_and_redirect(:user, user)
              end
            else
              flash[:error] =  service_route.capitalize + '유효하지 않은 이메일주소를 썼거나 공급자가 잘못되었습니다. 다른 공급자를 사용하거나 직접 가입해주세요. 이미 계정이 있다면 로그인해서' + service_route.capitalize + ' 에 추가해주세요'
              redirect_to new_user_session_path
            end
          end
        else
          # the user is currently signed in
          
          # check if this service is already linked to his/her account, if not, add it
          auth = Service.find_by_provider_and_uid(provider, uid)
          if !auth
            current_user.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
            flash[:notice] =  provider.capitalize + ' 공급자가 계정에 추가 되었습니다.'
            redirect_to services_path
          else
            flash[:notice] = service_route.capitalize + ' 공급자가 이미 계정에 추가되어 있습니다.'
            redirect_to services_path
          end  
        end  
      else
        flash[:error] =  service_route.capitalize + ' 오류.'
        redirect_to new_user_session_path
      end
    else
      flash[:error] = service_route.capitalize + '계정으로 로그인 하는 데 오류가 났습니다. 관리자에게 문의해주세요.'
      redirect_to new_user_session_path
    end
  end
end
