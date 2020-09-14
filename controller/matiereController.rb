# frozen_string_literal: true


load 'requests/matieres.rb'

# ROUTE : {GET}/api/matieres
# RETURN : JSON of all matieres
get '/api/matieres' do
  getMatieres
end
