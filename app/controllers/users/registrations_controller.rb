class Users::RegistrationsController < Devise::RegistrationsController
  def update
    # no mass assignment for country_id, we do it manually
    # check for existence of the country in case a malicious user manipulates the params (fails silently)

    if current_user.haslocalpw
      super
    else
      # this account has been created with a random pw / the user is signed in via an omniauth service
      # if the user does not want to set a password we remove the params to prevent a validation error
      if params[resource_name][:password].blank? 
        params[resource_name].delete(:password) 
        params[resource_name].delete(:password_confirmation) if params[resource_name][:password_confirmation].blank? 
      else
        # if the user wants to set a password we set haslocalpw for the future
        params[resource_name][:haslocalpw] = true
      end
      
      # this is copied over from the original devise controller, instead of update_with_password we use update_attributes
      if resource.update_attributes(params[resource_name])
        set_flash_message :notice, :updated
        sign_in resource_name, resource
        redirect_to after_update_path_for(resource)
      else
        clean_up_passwords(resource)
        render_with_scope :edit
      end
    end
  end
end
