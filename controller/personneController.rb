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
  getPeopleById(params[:idPeople])
end

# ROUTE : {POST}/api/personneByIdFull
# PARAM : STRING -> ID personne
# RETURN : JSON of information for the profile
post '/api/personneByIdFull' do
  getPersonneById(params[:idPeople])
end
