# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def getUnclosedCourses
  ro = OpenConnectBdd.query('SELECT c.intitule AS initule, c.heure AS heure, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.promo AS promo, p.nom AS nom, p.prenom AS prenom FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne WHERE c.status = 0 AND pc.rang_personne = 1')
  hash = ro.each(&:to_h)
  hash.to_json
end

def getCourseOfASpecificUser(lastname, firstname)
  ro = OpenConnectBdd.prepare('SELECT c.intitule AS initule, c.heure AS heure, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.promo AS promo, pc.rang_personne AS rang FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne WHERE c.status = 0 AND p.nom=? AND p.prenom=?')
  ro = ro.execute(lastname, firstname)
  hash = ro.each(&:to_h)
  hash.to_json
end

def getUnclosedCoursesByIntitule(intitule)
  request_object = OpenConnectBdd.prepare('SELECT c.intitule AS initule, c.heure AS heure, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.promo AS promo FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo WHERE c.status = 0 AND po.promo = ?')
  request_object = request_object.execute(intitule)
  hash = request_object.each(&:to_h)
  hash.to_json
end
