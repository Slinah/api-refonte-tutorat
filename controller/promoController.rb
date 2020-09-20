# frozen_string_literal: true

require 'mysql2'
load 'requests/promo.rb'


# ROUTE : {GET}/bot/getPromos
# RETURN : JSON of promos
get '/bot/getPromos' do
  getPromo
end

# ROUTE : {GET}/api/promoById
# RETURN : JSON of informations about a promo
get '/api/promos' do
  getPromos
end