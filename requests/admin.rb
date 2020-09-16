# frozen_string_literal: true

load 'requests/conf.rb'
load 'requests/personne.rb'


# Admin : Toutes les méthodes nécessaires au panel administrateur du site.


# method to promote an user in Administrator privileges
def postPromoteAdmin(idPersonne)
  ro = OpenConnectBdd.prepare('UPDATE personne SET role=1 WHERE personne.id_personne= ? ')
  ro.execute(idPersonne)
end

# method to demote an Administrator
def postDemoteAdmin(idPersonne)
  ro = OpenConnectBdd.prepare('UPDATE personne SET role=0 WHERE personne.id_personne=? ')
  ro.execute(idPersonne)
end

# method to delete an account
def postDeleteAccount(idPersonne)
  ro = OpenConnectBdd.prepare('DELETE FROM personne WHERE personne.id_personne=? ')
  ro.execute(idPersonne)
end

# method to add a subject
def postAddSubject(intitule)
  uuid = SecureRandom.uuid
  ro = OpenConnectBdd.prepare('INSERT INTO matiere (id_matiere, intitule, validationAdmin) VALUES (?, ?, 1)')
  ro.execute( uuid , intitule)
end

# method to validate a subject
def postValidateSubject(idSubject)
  ro = OpenConnectBdd.prepare('UPDATE matiere SET validationAdmin=1 WHERE matiere.id_matiere= ? ')
  ro.execute(idSubject)
end

# method to delete a subject
def postDeleteSubject(idSubject)
  ro = OpenConnectBdd.prepare('DELETE FROM matiere WHERE id_matiere= ?')
  ro.execute(idSubject)
end

# method to add a school
def postAddSchool(intitule)
  uuid = SecureRandom.uuid
  ro = OpenConnectBdd.prepare('INSERT INTO ecole (id_ecole, intitule) VALUES (?, ?)')
  ro.execute(uuid, intitule)
end

# method to delete a school
def postDeleteSchool(idSchool)
  ro = OpenConnectBdd.prepare('DELETE FROM ecole WHERE id_ecole= ?')
  ro.execute(idSchool)
end

# method to add a promo
def postAddPromo(idSchool, intitule)
  uuid = SecureRandom.uuid
  ro = OpenConnectBdd.prepare('INSERT INTO promo (id_promo, id_ecole, intitule) VALUES (?, ?, ?)')
  ro.execute(uuid, idSchool, intitule)
end

# method to delete a promo
def postDeletePromo(idPromo)
  ro = OpenConnectBdd.prepare('DELETE FROM promo WHERE id_promo= ?')
  ro.execute(idPromo)
end

# method to add a class
def postAddClass(intitule, idPromo)
  uuid = SecureRandom.uuid
  ro = OpenConnectBdd.prepare('INSERT INTO classe (id_classe, intitule, id_promo) VALUES (?, ?, ?)')
  ro.execute(uuid, intitule, idPromo)
end

# method to delete a class
def postDeleteClass(idClass)
  ro = OpenConnectBdd.prepare('DELETE FROM classe WHERE id_classe= ?')
  ro.execute(idClass)
end

# method to add a level
def postAddLevel(intitule)
  uuid = SecureRandom.uuid
  ro = OpenConnectBdd.prepare('INSERT INTO niveau (id_niveau, intitule) VALUES (?, ?)')
  ro.execute(uuid, intitule)
end

# method to delete a level
def postDeleteLevel(idLevel)
  ro = OpenConnectBdd.prepare('DELETE FROM niveau WHERE id_niveau= ?')
  ro.execute(idLevel)
end

# method to get all users of the site
def getAllUsers
  ro = OpenConnectBdd.query('SELECT p.id_personne, p.id_classe, p.nom, p.prenom, p.role, p.token, p.image, c.id_promo, c.intitule as intituleClass, pro.intitule as intitulePromo, pro.id_ecole, ec.intitule as intituleEcole  FROM personne p LEFT JOIN classe c ON p.id_classe = c.id_classe LEFT JOIN promo pro ON c.id_promo=pro.id_promo LEFT JOIN ecole ec ON pro.id_ecole = ec.id_ecole ORDER BY p.nom')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    'Impossible d\'acceder aux utilisateurs.'
  else
    hash.to_json
  end
end

def getAllSubjects
  ro = OpenConnectBdd.query('SELECT * FROM matiere ORDER BY intitule')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    'Pas de matiere disponible'
  else
    hash.to_json
  end
end

def getAllSchools
  ro = OpenConnectBdd.query('SELECT * FROM ecole ORDER BY intitule')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    'Pas d\'ecole disponible'
  else
    hash.to_json
  end
end

def getPromoFromSchool
  ro = OpenConnectBdd.query('SELECT ec.id_ecole, ec.intitule as intituleEcole, pro.id_promo, pro.intitule as intitulePromo FROM promo pro JOIN ecole ec ON pro.id_ecole = ec.id_ecole WHERE pro.id_ecole = ec.id_ecole ORDER BY intitulePromo')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    'Pas de promo lié à cette école.'
  else
    hash.to_json
  end
end

def getClassFromPromo
  ro = OpenConnectBdd.query('SELECT pro.id_promo, pro.intitule as intitulePromo, cl.id_classe, cl.intitule as intituleClasse FROM classe cl JOIN promo pro ON pro.id_promo = cl.id_promo WHERE cl.id_promo = pro.id_promo ORDER BY intituleClasse')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    'Pas de classe lié à cette promo.'
  else
    hash.to_json
  end
end

def getLevel
  ro = OpenConnectBdd.query('SELECT * FROM niveau')
  hash = ro.each(&:to_h)
  if hash.length.zero?
    'Problème d\'accès avec les niveaux.'
  else
    hash.to_json
  end
end