# -*- coding: utf-8 -*-

class RelaysController < ApplicationController
  before_filter :authenticate_user!

  def create
    @talk = Talk.find(params[:talk_id])
    @relay = @talk.relays.build(params[:relay])
    @relay.user = current_user
    
    respond_to do |format|
      if @relay.save
        format.html { redirect_to(@talk) }
        format.js { @lastest_relay = @relay }
      else
        format.html { redirect_to(@talk, :notice => '릴레이 작성이 실패했습니다.') }
      end
    end

  end

  def destroy
    @relay = current_user.relays.find(params[:id])
    @talk = Talk.find(params[:talk_id])
    @relay.destroy
    respond_to do |format|
      format.html { redirect_to @talk }
    end
  end
end
