# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def vExistsPersonne(lastname, firstname)
  request_object = OpenConnectBdd.prepare('SELECT id_personne FROM personne WHERE nom=? AND prenom=?')
  request_object = request_object.execute(lastname, firstname)
  request_object.each(&:to_h)
end

def vExistsPersonneByID(idPersonne)
  request_object = OpenConnectBdd.prepare('SELECT nom, prenom FROM personne WHERE id_personne=?')
  request_object = request_object.execute([ idPersonne ])
  request_object.each(&:to_h)
end