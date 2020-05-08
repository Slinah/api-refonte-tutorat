# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def getUnclosedCourses
  ro = OpenConnectBdd.query('SELECT e.intitule AS ecole, po.promo AS promo, c.intitule AS intitule, m.intitule AS matiere, c.date AS date, c.heure AS heure, c.salle AS salle, c.stage AS stage, p.nom AS nom, p.prenom AS prenom FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN ecole e ON po.id_ecole=e.id_ecole JOIN personne_cours cp ON c.id_cours=cp.id_cours JOIN personne p ON p.id_personne=cp.id_personne WHERE c.status=0 ')
  h = ro.each(&:to_h)
  h.to_json
end

