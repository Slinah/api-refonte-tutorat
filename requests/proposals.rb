# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def getUnclosedProposals
  request_object = OpenConnectBdd.query('SELECT m.intitule AS matiere, pr.intitule AS promo FROM proposition p JOIN matiere m ON p.id_matiere=m.id_matiere JOIN proposition_promo po ON p.id_proposition=po.id_proposition JOIN promo pr ON po.id_promo=pr.id_promo')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Pas de propositions pour le moment.'
  else
    hash.to_json
  end
end

