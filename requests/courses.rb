# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'
load 'requests/personne.rb'
load 'requests/promo.rb'

def getPeopleTutorCourseById(idPeople)
  request_object = OpenConnectBdd.prepare('SELECT pc.id_personne as id_personne,pr.intitule as promoIntitule,
c.id_cours as id_cours, pc.rang_personne as rang_personne, m.id_matiere as id_matiere, pr.id_promo as id_promo, c.intitule as coursIntitule,
c.date as date, c.commentaires as commentaires, c.nbParticipants as nbParticipants, c.duree as duree, c.status as status,
c.salle as salle, m.intitule as matiereIntitule from personne_cours pc join cours c on c.id_cours=pc.id_cours join matiere m on m.id_matiere=c.id_matiere join promo pr
on pr.id_promo=c.id_promo where pc.id_personne=? and pc.rang_personne=? and c.status=? order by date asc;')
  request_object = request_object.execute(idPeople, 1, 0)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "La personne ne donne aucuns cours !"}
    retourUser.to_json
  else
    hash.to_json
  end
end

def getPeopleCourseById(idPeople)
  request_object = OpenConnectBdd.prepare('SELECT * from personne_cours where id_personne=?;')
  request_object = request_object.execute(idPeople)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Personne inscrite sur aucun cours !"}
    retourUser.to_json
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
    request_object.execute(idPeople, idCourse, 0)
    retourUser = {"success" => "L'inscription au cours c'est bien passée !"}
    retourUser.to_json
  else
    retourUser = {"error" => "La personne est déjà inscrite à ce cours !"}
    retourUser.to_json
  end
end

def postCourse(id_personne, id_matiere, id_promo, intitule, date, commentaires)
  request_object = OpenConnectBdd.prepare('select * from cours where id_matiere=? and id_promo=? and date=? and intitule=? and commentaires=? and status=0;')
  request_object = request_object.execute(id_matiere, id_promo, date, intitule, commentaires)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    uuid = SecureRandom.uuid
    request_object = OpenConnectBdd.prepare('INSERT INTO `cours` (`id_cours`, `id_matiere`, `id_promo`, `intitule`,`date`,`commentaires`, `status`) VALUES (? , ? , ? , ? , ? , ? , ? );')
    request_object.execute(uuid, id_matiere, id_promo, intitule, date, commentaires, 0)
    request_object = OpenConnectBdd.prepare('INSERT INTO `personne_cours` (`id_personne`, `id_cours`, `rang_personne`) VALUES (?, ? , ?);')
    request_object.execute(id_personne, uuid, 1)
    request_object = OpenConnectBdd.prepare('DELETE FROM proposition where id_proposition in (select * from (select p.id_proposition from proposition p LEFT join proposition_promo pro on p.id_proposition=pro.id_proposition JOIN personne pe on pe.id_personne=p.id_createur join classe c on c.id_classe=pe.id_classe join promo prom on prom.id_promo = c.id_promo where p.id_matiere=? and prom.id_promo=?)tableTemporaire);')
    request_object.execute(id_matiere, id_promo)
    retourUser = {"success" => "La création du cours c'est bien passée !"}
    retourUser.to_json
  else
    retourUser = {"error" => "Une erreur c'est produite lors de la création du cours !"}
    retourUser.to_json
  end
end

def postCloseCourse(id_cours, id_matiere, id_promo, intitule, date, commentaires, nb_participants, duree, salle)
  request_object = OpenConnectBdd.prepare('select * from cours where id_cours=? and status=?;')
  request_object = request_object.execute(id_cours, 0)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Le cours n'éxiste pas !"}
    retourUser.to_json
  else
    request_object = OpenConnectBdd.prepare('update `cours` set `id_cours`=?,`id_matiere`=?,`id_promo`=?,`intitule`=?,`date`=?,
`commentaires`=?,`nbParticipants`=?,`duree`=?,`status`=?,`salle`=? where id_cours=? ;')
    request_object.execute(id_cours, id_matiere, id_promo, intitule, date, commentaires, nb_participants, duree, 1, salle, id_cours)
    retourUser = {"success" => "La mise à jour & la cloture du cours c'est bien passée !"}
    retourUser.to_json
  end
end

def postModifCourse(id_cours, id_matiere, id_promo, intitule, date, commentaires, nb_participants, duree, salle)
  request_object = OpenConnectBdd.prepare('select * from cours where id_cours=? and status=?;')
  request_object = request_object.execute(id_cours, 0)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Le cours n'éxiste pas !"}
    retourUser.to_json
  else
    request_object = OpenConnectBdd.prepare('update `cours` set `id_cours`=?,`id_matiere`=?,`id_promo`=?,`intitule`=?,`date`=?,
`commentaires`=?,`nbParticipants`=?,`duree`=?,`status`=?,`salle`=? where id_cours=? ;')
    request_object.execute(id_cours, id_matiere, id_promo, intitule, date, commentaires, nb_participants, duree, 0, salle, id_cours)
    retourUser = {"success" => "La mise à jour du cours c'est bien passée !"}
    retourUser.to_json
  end
end

def getUnclosedCourses
  request_object = OpenConnectBdd.query('SELECT c.id_cours AS idCours, c.commentaires AS commentaires,po.intitule AS promo, c.intitule AS intitule,
c.date AS date, c.salle AS salle, m.intitule AS matiere, p.nom AS nom, p.prenom AS prenom FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere
JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne
WHERE c.status = 0 AND pc.rang_personne = 1 ORDER BY date ASC')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    result = {"success" => "Pas de cours à venir pour cette promo !"}
    result.to_json
  else
    hash.to_json
  end
end

def getCoursesOfASpecificUser(lastname, firstname)
  if vExistsPersonne(lastname, firstname).length.zero?
    #'Cette personne n'existe pas dans notre base.'
    result = {"error" => "Cette personne n'existe pas dans notre base !"}
    result.to_json
  else
    request_object = OpenConnectBdd.prepare('SELECT c.intitule AS intitule, c.date AS date, c.salle
 AS salle, m.intitule AS matiere, po.intitule AS promo, pc.rang_personne AS rang FROM cours c JOIN matiere m ON
 c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo JOIN personne_cours pc ON c.id_cours=pc.id_cours
JOIN personne p ON pc.id_personne=p.id_personne WHERE c.status = 0 AND p.nom=? AND p.prenom=?')
    request_object = request_object.execute(lastname, firstname)
    hash = request_object.each(&:to_h)
    if hash.length.zero?
      result = {"error" => "Pas de cours à venir pour cette personne !"}
      result.to_json
    else
      hash.to_json
    end
  end
end

def getUnclosedCoursesByIntitule(intitule)
  if vExistsPromo(intitule).length.zero?
    result = {"error" => "Cette personne n'existe pas dans notre base !"}
    result.to_json
  else
    request_object = OpenConnectBdd.prepare('SELECT c.intitule AS intitule, c.date AS date, c.salle AS salle, m.intitule AS matiere, po.intitule AS promo FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN promo po ON c.id_promo=po.id_promo WHERE c.status = 0 AND po.intitule = ?')
    request_object = request_object.execute(intitule)
  end
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Pas de cours à venir pour cette promo !"}
    result.to_json
  else
    hash.to_json
  end
end

def getCourseOfTheDay
  request_object = OpenConnectBdd.query('SELECT c.date, p.nom, p.prenom, c.salle, m.intitule, p.role FROM cours c JOIN personne_cours pc ON c.id_cours=pc.id_cours JOIN personne p ON pc.id_personne=p.id_personne JOIN matiere m ON m.id_matiere=c.id_matiere WHERE c.date = CAST(NOW() AS DATE) AND p.role=1')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Pas de cours aujourd'hui !"}
    result.to_json
  else
    hash.to_json
  end
end

def getOwnCourses(idPersonne)
  ro = OpenConnectBdd.prepare('SELECT c.intitule as intituleCours, c.id_promo as idPromo, c.date, c.commentaires, c.salle, pro.intitule as intitulePromo FROM cours c JOIN personne_cours pc ON pc.id_cours = c.id_cours JOIN personne p ON p.id_personne = pc.id_personne JOIN promo pro ON pro.id_promo = c.id_promo WHERE pc.rang_personne = 1 AND c.status = 0 AND p.id_personne = ?')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Vous n'avez aucun cours à dispenser !"}
    result.to_json
  else
    hash.to_json
  end
end

def getRegisteredCourses(idPersonne)
  ro = OpenConnectBdd.prepare('SELECT c.intitule as intituleCours, c.id_promo as idPromo, c.date, c.commentaires, c.salle, pro.intitule as intitulePromo FROM cours c JOIN personne_cours pc ON pc.id_cours = c.id_cours JOIN personne p ON p.id_personne = pc.id_personne JOIN promo pro ON pro.id_promo = c.id_promo WHERE pc.rang_personne = 0 AND c.status = 0 AND p.id_personne = ?')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Vous n'êtes inscrit sur aucun cours !"}
    result.to_json
  else
    hash.to_json
  end
end
