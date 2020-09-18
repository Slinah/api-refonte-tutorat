# frozen_string_literal: true


load 'requests/matieres.rb'

# ROUTE : {GET}/api/matieres
# RETURN : JSON of all matieres
get '/api/matieres' do
  getMatieres
end

# ROUTE : {POST}/api/sendCreateMatiere
# PARAM : STRING -> matiere
post '/api/sendCreateMatiere' do
  postSendCreateMatiere(params[:matiere])
end