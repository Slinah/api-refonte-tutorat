# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def vExistsPromo(intitule)
  request_object = OpenConnectBdd.prepare('SELECT id_promo FROM promo WHERE intitule=?')
  request_object = request_object.execute(intitule)
  request_object.each(&:to_h)
end

def getPromo
  request_object = OpenConnectBdd.query('SELECT intitule FROM promo order by intitule ASC')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Pas de promos dans la base de données !"}
    result.to_json
  else
    hash.to_json
  end
end

def getPromos()
  request_object = OpenConnectBdd.prepare('SELECT * FROM promo order by intitule ASC')
  request_object = request_object.execute()
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Il n'y a pas de promo dans la base de donnée !"}
    result.to_json
  else
    hash.to_json
  end
end