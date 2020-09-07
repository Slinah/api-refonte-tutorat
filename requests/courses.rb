# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'
load 'requests/personne.rb'
load 'requests/promo.rb'


def getUnclosedCourses
  request_object = OpenConnectBdd.query('SELECT c.intitule AS intitule, c.heure AS heure, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.promo AS promo, p.nom AS nom, p.prenom AS prenom FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne WHERE c.status = 0 AND pc.rang_personne = 1')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de cours à venir.'
  else
    hash.to_json
  end
end

def getCourseOfASpecificUser(lastname, firstname)
  if vExistsPersonne(lastname, firstname).length.zero?
    'Cette personne n\'existe pas dans notre base.'
  else
    request_object = OpenConnectBdd.prepare('SELECT c.intitule AS intitule, c.heure AS heure, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.promo AS promo, pc.rang_personne AS rang FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne WHERE c.status = 0 AND p.nom=? AND p.prenom=?')
    request_object = request_object.execute(lastname, firstname)
  end
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de cours à venir pour cette personne.'
  else
    hash.to_json
  end
end

def getUnclosedCoursesByIntitule(intitule)
  if vExistsPromo(intitule).length.zero?
    'Cette promo n\'existe pas dans notre base.'
  else
    request_object = OpenConnectBdd.prepare('SELECT c.intitule AS intiule, c.heure AS heure, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.intitule AS promo FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo WHERE c.status = 0 AND po.intitule = ?')
    request_object = request_object.execute(intitule)
  end
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de cours à venir pour cette promo.'
  else
    hash.to_json
  end
end
