# frozen_string_literal: true


load 'requests/personne.rb'

# ROUTE : {POST}/api/personneByMail
# PARAM : STRING -> mail(mail)
# RETURN : JSON of people for a specified mail
# EXAMPLE : /api/personneByMail/cedric.menanteau@epsi.fr
post '/api/personneByMail/:mail' do |mail|
    getPeopleByMail(mail)
end

# ROUTE : {POST}/api/personneById
# PARAM : STRING -> ID personne
# RETURN : JSON of information for the profile
post '/api/personneById' do
  getPeopleById(params[:idPersonne])
end

# ROUTE : {POST}/api/personneByIdFull
# PARAM : STRING -> ID personne
# RETURN : JSON of information for the profile
post '/api/personneByIdFull' do
  getPersonneById(params[:idPeople])
end

# ROUTE : {POST}/api/postModifPref
# PARAM : STRING -> ID personne , int -> value of idCursor
# RETURN : Return to User Experience
post '/api/postModifPref' do
  postPreferenceById(params[:idPersonne],params[:idCursor])
end

# ROUTE : {POST}/api/getPreferenceById
# PARAM : STRING -> ID personne
# RETURN : Return preferences data
post '/api/getPreferenceById' do
  getPreferenceById(params[:idPersonne])
end
