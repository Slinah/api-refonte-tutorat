# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


def vExistsPromo(intitule)
  request_object = OpenConnectBdd.prepare('SELECT id_promo FROM ppromo WHERE promo=?')
  request_object = request_object.execute(intitule)
  request_object.each(&:to_h)
end
