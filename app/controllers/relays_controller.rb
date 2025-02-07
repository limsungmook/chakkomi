# -*- coding: utf-8 -*-

class RelaysController < ApplicationController
  before_filter :authenticate_user!

  def create
    @talk = Talk.find(params[:talk_id])
    @relay = @talk.relays.build(params[:relay])
    @relay.user = current_user
    respond_to do |format|
      if @relay.save
        AdminMailer.new_relay(@talk, @relay).deliver
        @talk.updated_at = @relay.created_at
        @talk.save
        session[:saved_relay_last] = @relay.created_at
        format.js { @lastest_relay = @relay }
      else
        format.html { redirect_to(@talk, :notice => '릴레이 작성이 실패했습니다.') }
      end
    end

  end

  def destroy
    @relay = Relay.find(params[:id])
    @talk = Talk.find(params[:talk_id])
    @relay.destroy
    respond_to do |format|
      format.html { redirect_to @talk }
    end
  end
end
