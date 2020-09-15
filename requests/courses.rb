# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'
load 'requests/personne.rb'
load 'requests/promo.rb'


def getUnclosedCourses
  request_object = OpenConnectBdd.query('SELECT c.id_cours AS idCours, c.commentaires AS commentaires,po.intitule AS promo, c.intitule AS intitule, c.date AS date, c.salle AS salle, m.intitule AS matiere, p.nom AS nom, p.prenom AS prenom FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne WHERE c.status = 0 AND pc.rang_personne = 1 ORDER BY date ASC')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de cours à venir.'
  else
    hash.to_json
  end
end

def getCoursesOfASpecificUser(lastname, firstname)
  if vExistsPersonne(lastname, firstname).length.zero?
    #'Cette personne n\'existe pas dans notre base.'
    result = {"noPers" => "Cette personne n'existe pas dans notre base."}
    result.to_json
  else
    request_object = OpenConnectBdd.prepare('SELECT c.intitule AS intitule, c.date AS date, c.salle
 AS salle, m.intitule AS matiere, po.intitule AS promo, pc.rang_personne AS rang FROM cours c JOIN matiere m ON
 c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours
JOIN personne p ON pc.id_personne=p.id_personne WHERE c.status = 0 AND p.nom=? AND p.prenom=?')
    request_object = request_object.execute(lastname, firstname)
    hash = request_object.each(&:to_h)
    if hash.length.zero?
      result = {"noCours" => "Pas de cours à venir pour cette personne."}
      result.to_json
    else
      hash.to_json
    end
  end
end

def getUnclosedCoursesByIntitule(intitule)
  if vExistsPromo(intitule).length.zero?
    'Cette promo n\'existe pas dans notre base.'
  else
    request_object = OpenConnectBdd.prepare('SELECT c.intitule AS intitule, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.intitule AS promo FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo WHERE c.status = 0 AND po.intitule = ?')
    request_object = request_object.execute(intitule)
  end
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Pas de cours à venir pour cette promo."}
    result.to_json
  else
    hash.to_json
  end
end

def getCourseOfTheDay
  request_object = OpenConnectBdd.query('SELECT c.date, c.heure, p.nom, p.prenom, c.salle, m.intitule, p.role FROM cours c JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne JOIN matiere m ON m.id_matiere=c.id_matiere WHERE c.date = CAST(NOW() AS DATE) AND p.role=1')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de cours aujourd hui.'
  else
    hash.to_json
  end
end

def getOwnCourses(idPersonne)
  ro = OpenConnectBdd.prepare('SELECT c.intitule as intituleCours, c.id_promo as idPromo, c.date, c.commentaires, c.salle, pro.intitule as intitulePromo FROM cours c JOIN personne_cours pc ON pc.id_cours = c.id_cours JOIN personne p ON p.id_personne = pc.id_personne JOIN promo pro ON pro.id_promo = c.id_promo WHERE pc.rang_personne = 1 AND c.status = 0 AND p.id_personne = ?')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    'Vous n\'avez aucun cours à dispenser'
  else
    hash.to_json
  end
end

def getRegisteredCourses(idPersonne)
  ro = OpenConnectBdd.prepare('SELECT c.intitule as intituleCours, c.id_promo as idPromo, c.date, c.commentaires, c.salle, pro.intitule as intitulePromo FROM cours c JOIN personne_cours pc ON pc.id_cours = c.id_cours JOIN personne p ON p.id_personne = pc.id_personne JOIN promo pro ON pro.id_promo = c.id_promo WHERE pc.rang_personne = 0 AND c.status = 0 AND p.id_personne = ?')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    'Vous n\'êtes inscrit sur aucun cours'
  else
    hash.to_json
  end
end
