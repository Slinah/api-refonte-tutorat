# frozen_string_literal: true

require 'sequel'
require 'mysql2'
load 'requests/conf.rb'


Bdd = Base.new
Bdd.init
OpenConnectBdd = Sequel.connect(adapter: 'mysql2', host: Bdd.host, database: Bdd.database, user: Bdd.user, password: Bdd.pass)

def getUsers
  result_objects = OpenConnectBdd["SELECT * FROM personne"].all
  hash = result_objects.collect { |row| row.to_h }
  hash.to_json
end
