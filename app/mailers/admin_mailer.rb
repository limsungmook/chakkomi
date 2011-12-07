# -*- coding: utf-8 -*-

class AdminMailer < ActionMailer::Base
  default from: "chakkomi@gmail.com"

  def new_talk(talk)
    @talk = talk
    mail(:to => 'chakkomi@naver.com', :subject => "새 토크가 올라왔습니다(" + @talk.content + ")")
  end

  def new_relay(talk, relay)
    @talk = talk
    @relay = relay
    mail(:to => 'chakkomi@naver.com', :subject => "새 릴레이가 올라왔습니다(" + @relay.content + ")")

  end
end
