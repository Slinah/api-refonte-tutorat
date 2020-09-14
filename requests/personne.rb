# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'

def getPersonneById(idPeople)
  request_object = OpenConnectBdd.prepare('SELECT p.nom as nom, p.prenom as prenom, pro.intitule as intitulePromo, p.id_personne as id_createur, pro.id_promo as id_promo from personne p join classe c on p.id_classe=c.id_classe join promo pro on c.id_promo=pro.id_promo join ecole e on pro.id_ecole=e.id_ecole where id_personne=?;')
  request_object = request_object.execute(idPeople)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'L\'id de cette personne n\'est pas présente dans notre base de donnée.'
  else
    hash.to_json
  end
end


def vExistsPersonne(lastname, firstname)
  request_object = OpenConnectBdd.prepare('SELECT id_personne FROM personne WHERE nom=? AND prenom=?')
  request_object = request_object.execute(lastname, firstname)
  request_object.each(&:to_h)
end

def vExistsPersonneByMail(mail)
  request_object = OpenConnectBdd.prepare('SELECT COUNT(*) FROM personne WHERE mail=?')
  request_object = request_object.execute(mail)
  # request_object.each(&:to_h)
  # puts(request_object)
end

def getPeopleByMail(mail)
  unless [nil, 0].include?(vExistsPersonne(mail)[0])
    # request_object = OpenConnectBdd.prepare()
    # request_object = request_object.execute(mail)
    # request_object.each(&:to_h)
  end
end