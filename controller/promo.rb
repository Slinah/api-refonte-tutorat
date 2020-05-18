# frozen_string_literal: true

require 'mysql2'
load 'requests/promo.rb'


# ROUTE : {GET}/api/getPromos
# RETURN : JSON of promos
get '/api/getPromos' do
  getPromo
end
