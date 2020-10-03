# frozen_string_literal: true

 # load 'requests/conf.rb'

def getMatieres
  request_object = OpenConnectBdd.query('SELECT id_matiere as id_matiere, intitule as intitule from matiere where validationAdmin=1 ORDER BY intitule ASC')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Aucune de matière validée par les admins présente dans la base donnée"}
    result.to_json
  else
    hash.to_json
  end
end


def postSendCreateMatiere(matiere)
  request_object = OpenConnectBdd.prepare('Select * from matiere where intitule=?')
  request_object = request_object.execute(matiere)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    uuid = SecureRandom.uuid
    request_object = OpenConnectBdd.prepare('INSERT INTO `matiere` (`id_matiere`,`intitule`,`validationAdmin`) VALUES (?, ?, ?);')
    request_object.execute(uuid, matiere, 0)
    uuid.to_json
  else
    result = {"error" => "Il y a déjà une matière comportant cet intitulé dans la base de donnée"}
    result.to_json
  end
end
