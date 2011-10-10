# -*- coding: utf-8 -*-

class TalksController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :check_update, :check_update_relay]

  #최신 글의 여부를 체크한다. 있으면 true, 없으면 false
  def check_update
    @talk_last = Talk.find(:first)  # updated_at 기준 최신글
    respond_to do |format|
      if( @talk_last.updated_at != session[:saved_talk_last] )
        session[:saved_talk_last] = @talk_last.updated_at
        format.js {@retval = 1}
      else
        format.js {@retval = 0}
      end
    end
  end
  
  def check_update_relay
    @talk = Talk.find(params[:talk_id])
    @relay_last = @talk.relays.find(:first)
    hello = session[:saved_relay_last]
    respond_to do |format|
      if( @relay_last.created_at != session[:saved_relay_last] )
        session[:saved_relay_last] = @relay_last.created_at
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
    @talk_last = Talk.find(:first)
    if !@talk_last.nil?
      session[:saved_talk_last] = @talk_last.updated_at
      @talks = Talk.paginate(:per_page => 10, :page => params[:page])    
    end
      respond_to do |format|
        format.html # index.html.erb
        format.js
        format.xml  { render :xml => @talks }
      end

  end

  # GET /talks/1
  # GET /talks/1.xml
  def show
    @talk = Talk.find(params[:id])
    @relay_last = @talk.relays.find(:first)
    session[:saved_relay_last] = @relay_last.created_at
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @talk }
    end
  end

  # GET /talks/new
  # GET /talks/new.xml
  def new
    @talk = Talk.new

    respond_to do |format|
      format.html # new.html.erb
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
        @talks = Talk.paginate(:per_page => 10, :page => params[:page])
        #        format.html { redirect_to(@talk, :notice => 'Talk was successfully created.') }
        format.html { redirect_to(@talk) }
        format.js { @lastest_talk = @talk }
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
    @talk.destroy

    respond_to do |format|
      format.html { redirect_to('/talks') }
      format.js
    end
  end

end


