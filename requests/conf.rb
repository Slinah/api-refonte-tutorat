# frozen_string_literal: true

class Base
  def init
    @host = 'localhost'
    @database = 'tutoratrefonte'
    @user = 'root'
    @pass = ''
  end

  attr_reader :host

  attr_reader :database

  attr_reader :user

  attr_reader :pass
end
