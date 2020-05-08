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


Bdd = Base.new
Bdd.init
OpenConnectBdd = Mysql2::Client.new(host: Bdd.host,
                                    database: Bdd.database,
                                    user: Bdd.user)
