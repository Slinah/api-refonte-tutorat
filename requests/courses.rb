# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'
load 'requests/personne.rb'
load 'requests/promo.rb'

def getPeopleCourseById(idPeople)
  request_object = OpenConnectBdd.prepare('SELECT * from personne_cours where id_personne=?;')
  request_object = request_object.execute(idPeople)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Personne inscrite sur aucun cours.'
  else
    hash.to_json
  end
end

def postRegistrationCourse(idPeople, idCourse)
  request_object = OpenConnectBdd.prepare('select * from personne_cours where id_personne=? and id_cours=?;')
  request_object = request_object.execute(idPeople, idCourse)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    request_object = OpenConnectBdd.prepare('INSERT INTO `personne_cours` (`id_personne`, `id_cours`, `rang_personne`) VALUES (?, ? , ?);')
    request_object.execute(idPeople, idCourse,0)
  end
end

def postCourse(id_personne,id_matiere,id_promo,intitule,date,commentaires)
  request_object = OpenConnectBdd.prepare('select * from cours where id_matiere=? and id_promo=? and date=? and intitule=? and commentaires=?;')
  request_object = request_object.execute(id_matiere, id_promo,date,intitule,commentaires)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    uuid = SecureRandom.uuid
    request_object = OpenConnectBdd.prepare('INSERT INTO `cours` (`id_cours`, `id_matiere`, `id_promo`, `intitule`,`date`,`commentaires`, `status`, `stage`) VALUES (? , ? , ? , ? , ? , ? , ? , ?);')
    request_object.execute(uuid, id_matiere,id_promo,intitule,date,commentaires,0,0)
    request_object = OpenConnectBdd.prepare('INSERT INTO `personne_cours` (`id_personne`, `id_cours`, `rang_personne`) VALUES (?, ? , ?);')
    request_object.execute(id_personne, uuid, 1)
    request_object = OpenConnectBdd.prepare('DELETE FROM proposition where id_proposition in (select * from (select p.id_proposition from proposition p LEFT join proposition_promo pro on p.id_proposition=pro.id_proposition JOIN personne pe on pe.id_personne=p.id_createur join classe c on c.id_classe=pe.id_classe join promo prom on prom.id_promo = c.id_promo where p.id_matiere=? and prom.id_promo=?)tableTemporaire);')
    request_object.execute(id_matiere, id_promo)
  end
end

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
  request_object = OpenConnectBdd.query('SELECT c.date, p.nom, p.prenom, c.salle, m.intitule, p.role FROM cours c JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne JOIN matiere m ON m.id_matiere=c.id_matiere WHERE c.date = CAST(NOW() AS DATE) AND p.role=1')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de cours aujourd hui.'
  else
    hash.to_json
  end
end

def getNbrOfCourse
  request_object = OpenConnectBdd.query('SELECT COUNT(id_log) as countCourse FROM logs')
  hash = request_object.each(&:to_h)
    hash.to_json
end

def getLatestCourse
  request_object = OpenConnectBdd.query('SELECT l.id_cours as logIdCours, l.id_cours, l.heure as logDateHeure, m.intitule as nomMatiere, c.intitule as nomCours, p.intitule as nomPromo FROM logs l JOIN cours c on c.id_cours=l.id_cours JOIN matiere m on c.id_matiere=m.id_matiere JOIN promo p on c.id_promo=p.id_promo ORDER BY l.heure ASC LIMIT 1')
  hash = request_object.each(&:to_h)
    hash.to_json
end

