# frozen_string_literal: true

require 'mysql2'
load 'requests/promo.rb'


# ROUTE : {GET}/bot/getPromos
# RETURN : JSON of promos
get '/bot/getPromos' do
  getPromo
end
