# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'
load 'requests/personne.rb'


# Admin : Toutes les méthodes nécessaires au panel administrateur du site.


# method to promote an user in Administrator privileges
def postPromoteAdmin(idPersonne)
  ro = OpenConnectBdd.prepare('select * from personne p where p.id_personne=? ')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "L'utilisateur n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('UPDATE personne SET role=1 WHERE personne.id_personne= ? ')
    ro.execute(idPersonne)
    retourUser = {"success" => "La promotion de l'utilisateur c'est bien passée !"}
    retourUser.to_json
  end
end

# method to demote an Administrator
def postDemoteAdmin(idPersonne)
  ro = OpenConnectBdd.prepare('select * from personne p where p.id_personne=? ')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "L'utilisateur n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('UPDATE personne SET role=0 WHERE personne.id_personne= ? ')
    ro.execute(idPersonne)
    retourUser = {"success" => "La retrogradation de l'utilisateur c'est bien passée !"}
    retourUser.to_json
  end
end

# method to delete an account
def postDeleteAccount(idPersonne)
  ro = OpenConnectBdd.prepare('select * from personne p where p.id_personne=? ')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "L'utilisateur n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('DELETE FROM personne WHERE personne.id_personne=? ')
    ro.execute(idPersonne)
    retourUser = {"success" => "La suppression de l'utilisateur c'est bien passée !"}
    retourUser.to_json
  end
end

# method to add a subject
def postAddSubject(intitule)
  uuid = SecureRandom.uuid
  ro = OpenConnectBdd.prepare('INSERT INTO matiere (id_matiere, intitule, validationAdmin) VALUES (?, ?, 1)')
  ro.execute(uuid, intitule)
  retourUser = {"success" => "La matière à bien été ajoutée !"}
  retourUser.to_json
end

# method to validate a subject
def postValidateSubject(idSubject)
  ro = OpenConnectBdd.prepare('select * from matiere m where m.id_matiere=? ')
  ro = ro.execute(idSubject)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "La matière n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('UPDATE matiere SET validationAdmin=1 WHERE matiere.id_matiere= ? ')
    ro.execute(idSubject)
    retourUser = {"success" => "La validation de la matière c'est bien passée !"}
    retourUser.to_json
  end
end

# method to delete a subject
def postDeleteSubject(idSubject)
  ro = OpenConnectBdd.prepare('select * from matiere m where m.id_matiere=? ')
  ro = ro.execute(idSubject)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "La matière n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('DELETE FROM matiere WHERE id_matiere= ?')
    ro.execute(idSubject)
    retourUser = {"success" => "La suppression de la matière c'est bien passée !"}
    retourUser.to_json
  end
end

# method to add a school
def postAddSchool(intitule)
  ro = OpenConnectBdd.prepare('select * from ecole e where e.intitule=? ')
  ro = ro.execute(intitule)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    uuid = SecureRandom.uuid
    ro = OpenConnectBdd.prepare('INSERT INTO ecole (id_ecole, intitule) VALUES (?, ?)')
    ro.execute(uuid, intitule)
    retourUser = {"success" => "L'école à bien été ajoutée !"}
    retourUser.to_json
  else
    retourUser = {"error" => "Une école avec le même nom est déjà présente dans la base de donnée !"}
    retourUser.to_json
  end
end

# method to delete a school
def postDeleteSchool(idSchool)
  ro = OpenConnectBdd.prepare('select * from ecole e where e.id_ecole=? ')
  ro = ro.execute(idSchool)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "L'école n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('DELETE FROM ecole WHERE id_ecole= ?')
    ro.execute(idSchool)
    retourUser = {"success" => "L'école à bien été supprimé de la base de donnée !"}
    retourUser.to_json
  end
end

# method to add a promo
def postAddPromo(idSchool, intitule)
  ro = OpenConnectBdd.prepare('select * from promo p where p.intitule=? and p.id_ecole=?')
  ro = ro.execute(intitule, idSchool)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    uuid = SecureRandom.uuid
    ro = OpenConnectBdd.prepare('INSERT INTO promo (id_promo, id_ecole, intitule) VALUES (?, ?, ?)')
    ro.execute(uuid, idSchool, intitule)
    retourUser = {"success" => "La promo à bien été ajoutée !"}
    retourUser.to_json
  else
    retourUser = {"error" => "Une promo avec ce nom et cette école existe déjà dans la base de donnée !"}
    retourUser.to_json
  end
end

# method to delete a promo
def postDeletePromo(idPromo)
  ro = OpenConnectBdd.prepare('select * from promo p where p.id_promo=?')
  ro = ro.execute(idPromo)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "La promo n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('DELETE FROM promo WHERE id_promo= ?')
    ro.execute(idPromo)
    retourUser = {"success" => "La promo à bien été supprimé de la base de donnée !"}
    retourUser.to_json
  end
end

# method to add a class
def postAddClass(intitule, idPromo)
  ro = OpenConnectBdd.prepare('select * from classe c where c.intitule=? and c.id_promo=?')
  ro = ro.execute(intitule,idPromo)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    uuid = SecureRandom.uuid
    ro = OpenConnectBdd.prepare('INSERT INTO classe (id_classe, intitule, id_promo) VALUES (?, ?, ?)')
    ro.execute(uuid, intitule, idPromo)
    retourUser = {"success" => "La classe à bien été ajouté à la base de donnée !"}
    retourUser.to_json
  else
    retourUser = {"error" => "Une classe avec ce nom et cette école existe déjà dans la base de donnée !"}
    retourUser.to_json
  end
end

# method to delete a class
def postDeleteClass(idClass)
  ro = OpenConnectBdd.prepare('select * from classe c where c.id_classe=?')
  ro = ro.execute(idClass)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "La classe n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('DELETE FROM classe WHERE id_classe= ?')
    ro.execute(idClass)
    retourUser = {"success" => "La classe à bien été supprimé de la base de donnée !"}
    retourUser.to_json
  end
end

# method to add a level
def postAddLevel(intitule)
  ro = OpenConnectBdd.prepare('select * from niveau n where n.intitule=?')
  ro = ro.execute(intitule)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    uuid = SecureRandom.uuid
    ro = OpenConnectBdd.prepare('INSERT INTO niveau (id_niveau, intitule) VALUES (?, ?)')
    ro.execute(uuid, intitule)
    retourUser = {"success" => "Le niveau à bien été ajouté à la base de donnée !"}
    retourUser.to_json
  else
    retourUser = {"error" => "Un niveau avec ce nom existe déjà dans la base de donnée !"}
    retourUser.to_json
  end
end

#////////////
# method to delete a level
def postDeleteLevel(idLevel)
  ro = OpenConnectBdd.prepare('select * from niveau n where n.id_niveau=?')
  ro = ro.execute(idLevel)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "La niveau n'existe pas dans la base de donnée !"}
    retourUser.to_json
  else
    ro = OpenConnectBdd.prepare('DELETE FROM niveau WHERE id_niveau= ?')
    ro.execute(idLevel)
    retourUser = {"success" => "La niveau à bien été supprimé de la base de donnée !"}
    retourUser.to_json
  end

end

# method to get all users of the site
def getAllUsers
  ro = OpenConnectBdd.query('SELECT p.id_personne, p.id_classe, p.nom, p.prenom, p.role, p.token, p.image, c.id_promo,
c.intitule as intituleClass, pro.intitule as intitulePromo, pro.id_ecole, ec.intitule as intituleEcole
FROM personne p
LEFT JOIN classe c ON p.id_classe = c.id_classe
LEFT JOIN promo pro ON c.id_promo=pro.id_promo
LEFT JOIN ecole ec ON pro.id_ecole = ec.id_ecole
ORDER BY p.nom')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Impossible d'accèder aux utilisateurs !"}
    retourUser.to_json
  else
    hash.to_json
  end
end

def getAllSubjects
  ro = OpenConnectBdd.query('SELECT * FROM matiere ORDER BY intitule')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Pas de matière disponbible !"}
    retourUser.to_json
  else
    hash.to_json
  end
end

def getAllSchools
  ro = OpenConnectBdd.query('SELECT * FROM ecole ORDER BY intitule')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Pas d'ecole disponible !"}
    retourUser.to_json
  else
    hash.to_json
  end
end

def getPromoFromSchool
  ro = OpenConnectBdd.query('SELECT ec.id_ecole, ec.intitule as intituleEcole, pro.id_promo, pro.intitule as intitulePromo
FROM promo pro JOIN ecole ec ON pro.id_ecole = ec.id_ecole WHERE pro.id_ecole = ec.id_ecole ORDER BY intitulePromo')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Pas de promo lié à cette école !"}
    retourUser.to_json
  else
    hash.to_json
  end
end

def getClassFromPromo
  ro = OpenConnectBdd.query('SELECT pro.id_promo, pro.intitule as intitulePromo, cl.id_classe, cl.intitule as intituleClasse
FROM classe cl JOIN promo pro ON pro.id_promo = cl.id_promo WHERE cl.id_promo = pro.id_promo ORDER BY intituleClasse')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Pas de classe lié à cette promo !"}
    retourUser.to_json
  else
    hash.to_json
  end
end

def getLevel
  ro = OpenConnectBdd.query('SELECT * FROM niveau')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    retourUser = {"error" => "Problème d'accès avec les niveaux !"}
    retourUser.to_json
  else
    hash.to_json
  end
end