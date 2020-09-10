# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'

def getLatestCourseByLogs
  request_object = OpenConnectBdd.query('SELECT l.id_cours as logIdCours, l.id_cours, l.heure as logDateHeure, m.intitule as nomMatiere, c.intitule as nomCours, p.intitule as nomPromo FROM logs l JOIN cours c on c.id_cours=l.id_cours JOIN matiere m on c.id_matiere=m.id_matiere JOIN promo p on c.id_promo=p.id_promo ORDER BY l.heure ASC LIMIT 1')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de nouvelles propositions pour le moment.'
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

def getNbrOfCourseInLog
  request_object = OpenConnectBdd.query('SELECT COUNT(id_log) as countCourse FROM logs')
  hash = request_object.each(&:to_h)
  hash.to_json
end

def getLatestPropositionByLogs
  request_object = OpenConnectBdd.query('SELECT lp.id_log as IdLogProposal, lp.heure as hourProposals, m.intitule as nomMatiere, pe.nom, pe.prenom FROM logs_proposition lp JOIN proposition p on p.id_proposition=lp.id_proposition JOIN matiere m on p.id_matiere=m.id_matiere JOIN personne pe on p.id_createur=pe.id_personne ORDER BY lp.heure ASC LIMIT 1')
  hash = request_object.each(&:to_h)
  hash.to_json
end
