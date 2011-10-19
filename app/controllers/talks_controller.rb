# -*- coding: utf-8 -*-

class TalksController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :check_update, :check_update_relay]

  #최신 글의 여부를 체크한다. 있으면 true, 없으면 false
  def check_update
    if !session[:mid].nil?
      @mid = session[:mid]
    else
      return false
    end

    @talk_last = Talk.find(:first, :conditions => ["mid = ?", @mid])  # updated_at 기준 최신글
    respond_to do |format|
      if( @talk_last.updated_at != params[:recent_talk] )
        format.js {@retval = 1}
      else
        format.js {@retval = 0}
      end
    end
  end
  
  def check_update_relay
    @relay_last = Relay.find(:first, :conditions => ["talk_id = ?", params[:talk_id]])
    
    respond_to do |format|
      if( @relay_last.created_at != params[:recent_relay] )
        format.js {@retval = 1}
      else
        format.js {@retval = 0}
      end
    end
  end



  # GET /talks
  # GET /talks.xml
  def index
    # 지속적인 최신글의 체크를 위해 지금까지의 최신글을 세션에 넣어놓는다.
    if !params[:mid].nil?
      @mid = params[:mid]
    end
    @talk_last = Talk.find(:first, :conditions => ["mid = ?", @mid])

    if !@talk_last.nil?
      session[:saved_talk_last] = @talk_last.updated_at
      @recent_talk = @talk_last.updated_at
      @talks = Talk.where(:mid => @mid).paginate(:per_page => 10, :page => params[:page])    
    end
    respond_to do |format|
      if session[:mid] == 'qna'
        format.html { render :layout => 'shop' }# index.html.erb
      else
        format.html # index.html.erb
      end
      format.js
      format.xml  { render :xml => @talks }
    end
    
  end

  # GET /talks/1
  # GET /talks/1.xml
  def show
    @talk = Talk.find(params[:id])
    @relay_last = @talk.relays.find(:first)
    @recent_relay = @relay_last.updated_at
    respond_to do |format|
      if session[:mid] == 'qna'
        format.html { render :layout => 'shop' }# index.html.erb
      else
        format.html # index.html.erb
      end
      format.js
      format.xml  { render :xml => @talk }
    end
  end

  # GET /talks/1/edit
  def edit
    @talk = Talk.find(params[:id])
  end

  # POST /talks
  # POST /talks.xml
  def create
    @talk = Talk.new(params[:talk])
    
    @talk.user = current_user
    respond_to do |format|
      if @talk.save
        @relay = Relay.new()
        @relay.user = @talk.user
        @relay.content = @talk.content
        @relay.talk_id = @talk.id
        @relay.save
        session[:saved_talk_last] = @talk.updated_at
        @mid = @talk.mid
        @talks = Talk.paginate(:per_page => 10, :page => params[:page])
        #        format.html { redirect_to(@talk, :notice => 'Talk was successfully created.') }
        format.html { redirect_to(@talk) }
        format.js {@talk}
        format.xml  { render :xml => @talk, :status => :created, :location => @talk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /talks/1
  # PUT /talks/1.xml
  def update
    @talk = Talk.find(params[:id])

    respond_to do |format|
      if @talk.update_attributes(params[:talk])
        format.html { redirect_to(@talk, :notice => 'Talk was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /talks/1
  # DELETE /talks/1.xml
  def destroy

    @talk = Talk.find(params[:id])
    @mid = @talk.mid
    @talk.destroy

    respond_to do |format|
      format.html { redirect_to('/talks') }
      format.js
    end
  end

end


