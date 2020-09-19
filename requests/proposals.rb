# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def getUnclosedProposals
  request_object = OpenConnectBdd.query('SELECT m.intitule AS matiere, pr.intitule AS promo, p.id_proposition as id_proposition,
p.id_createur as id_createur, p.id_matiere as id_matiere, p.commentaire as commentaire, po.id_promo as id_promo
FROM proposition p JOIN matiere m ON p.id_matiere=m.id_matiere JOIN proposition_promo po
ON p.id_proposition=po.id_proposition JOIN promo pr ON po.id_promo=pr.id_promo')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de propositions pour le moment.'
  else
    hash.to_json
  end
end

def postSendProposalCoursesPeople(idPeople, idMatiere, commentaire)
  uuid = SecureRandom.uuid
  request_object = OpenConnectBdd.prepare('SELECT * FROM proposition p where id_createur=? and id_matiere=?')
  request_object = request_object.execute(idPeople, idMatiere)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    #si aucune proposition n'est lié, alors on créer une proposition
    request_object = OpenConnectBdd.prepare('INSERT INTO `proposition` (`id_proposition`,`id_createur`,`id_matiere`, `commentaire`) VALUES (?, ?, ?, ?);')
    request_object.execute(uuid, idPeople, idMatiere, commentaire)
    uuid.to_json
  else
    #si une proposition existe, alors, on renvoie un false
    false.to_json
  end
end

def postSendProposalCoursesPromo(idProposition, idPromo)
  request_object = OpenConnectBdd.prepare('SELECT * from proposition_promo where id_proposition=? and id_promo=?')
  request_object = request_object.execute(idProposition,idPromo)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    request_object = OpenConnectBdd.prepare('INSERT INTO `proposition_promo` (`id_proposition`,`id_promo`) VALUES (?, ?);')
    request_object.execute(idProposition, idPromo)
  else
    'Ce couple proposition - promo est déjà présent dans la base donnée.'
  end
end
