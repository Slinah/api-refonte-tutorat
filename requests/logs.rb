# frozen_string_literal: true

# load 'requests/conf.rb'

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

def getLatestProposalsByLogs
  request_object = OpenConnectBdd.query('SELECT lp.id_proposition as IdLogProposal, lp.heure as hourProposals, m.intitule as nomMatiere, pe.nom, pe.prenom, pro.intitule as nomPromo FROM logs_proposition lp JOIN proposition p on p.id_proposition=lp.id_proposition JOIN matiere m on p.id_matiere=m.id_matiere JOIN personne pe on p.id_createur=pe.id_personne JOIN proposition_promo po on p.id_proposition=po.id_proposition JOIN promo pro on pro.id_promo=po.id_promo ORDER BY lp.heure ASC LIMIT 1')
  hash = request_object.each(&:to_h)
  hash.to_json
  if hash.length.zero?
    'Pas de nouvelles propositions pour le moment.'
  else
    hash.to_json
  end
end
