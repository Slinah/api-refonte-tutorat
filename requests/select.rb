# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


Bdd = Base.new
Bdd.init
OpenConnectBdd = Mysql2::Client.new(:host => Bdd.host,
                                    :database => Bdd.database,
                                    :user => Bdd.user)
def getUsers
  query = OpenConnectBdd.query('SELECT * FROM personne')
  query
end
