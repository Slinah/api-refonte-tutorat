# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def vExistsPersonne(lastname, firstname)
  request_object = OpenConnectBdd.prepare('SELECT id_personne FROM personne WHERE nom=? AND prenom=?')
  request_object = request_object.execute(lastname, firstname)
  request_object.each(&:to_h)
end

def vExistsPersonneByMail(mail)
  request_object = OpenConnectBdd.prepare('SELECT COUNT(*) FROM personne WHERE mail=?')
  request_object = request_object.execute(mail)
  # request_object.each(&:to_h)
  # puts(request_object)
end

def getPeopleByMail(mail)
  unless [nil, 0].include?(vExistsPersonne(mail)[0])
    # request_object = OpenConnectBdd.prepare()
    # request_object = request_object.execute(mail)
    # request_object.each(&:to_h)
  end
end