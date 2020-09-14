# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def vExistsPromo(intitule)
  request_object = OpenConnectBdd.prepare('SELECT id_promo FROM promo WHERE intitule=?')
  request_object = request_object.execute(intitule)
  request_object.each(&:to_h)
end

def getPromo
  request_object = OpenConnectBdd.query('SELECT intitule FROM promo')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de promos dans la base de données.'
  else
    hash.to_json
  end
end

def getPromos()
  request_object = OpenConnectBdd.prepare('SELECT * FROM promo')
  request_object = request_object.execute()
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Il n\'y a pas de promo dans la base de donné'
  else
    hash.to_json
  end
end