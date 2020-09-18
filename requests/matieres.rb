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


def postSendCreateMatiere(matiere)
  uuid = SecureRandom.uuid
  request_object = OpenConnectBdd.prepare('Select * from matiere where intitule=?')
  request_object = request_object.execute(matiere)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    request_object = OpenConnectBdd.prepare('INSERT INTO `matiere` (`id_matiere`,`intitule`,`validationAdmin`) VALUES (?, ?, ?);')
    request_object.execute(uuid, matiere, 0)
    uuid.to_json
  else
    'Il y a déjà une matière comportant cet intitulé dans la base de donnée'
  end
end