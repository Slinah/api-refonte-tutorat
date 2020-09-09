# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'

def getLatestCourseByLogs
  request_object = OpenConnectBdd.query('SELECT c.id_cours AS id_cours, c.intitule AS intitule, c.heure AS heure, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.intitule AS promo, p.nom AS nom, p.prenom AS prenom FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne WHERE c.id_cours=(SELECT l.id_cours FROM logs l)')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de nouveaux cours pour le moment.'
  else
    hash.to_json
  end
end


def deleteLogCourseById(id_course)
  request_object = OpenConnectBdd.prepare('DELETE FROM logs WHERE id_cours=?')
  request_object.execute(id_course)
  body 'Course log successfully deleted from database'
  status 200
end


def getLatestProposalByLogs
  request_object = OpenConnectBdd.query('SELECT m.intitule AS matiere, pr.intitule AS promo FROM proposition p JOIN matiere m ON p.id_matiere=m.id_matiere JOIN proposition_promo po ON p.id_proposition=po.id_proposition JOIN promo pr ON po.id_promo=pr.id_promo WHERE p.id_proposition=(SELECT l.id_proposition FROM logs_proposition l)')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de nouvelles propositions pour le moment.'
  else
    hash.to_json
  end
end


def deleteLogProposalById(id_proposal)
  request_object = OpenConnectBdd.prepare('DELETE FROM logs_proposition WHERE id_proposition=?')
  request_object.execute(id_proposal)
  body 'Proposal log successfully deleted from database'
  status 200
end
