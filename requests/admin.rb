# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'
load 'requests/personne.rb'

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