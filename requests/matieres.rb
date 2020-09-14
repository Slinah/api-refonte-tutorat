# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'

def getMatieres
  request_object = OpenConnectBdd.query('SELECT id_matiere as id_matiere, intitule as intitule from matiere where validationAdmin=1 ORDER BY intitule ASC')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de matière dans la base donnée'
  else
    hash.to_json
  end
end