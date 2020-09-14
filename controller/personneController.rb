# frozen_string_literal: true


load 'requests/personne.rb'

# ROUTE : {POST}/api/personneByMail
# PARAM : STRING -> mail(mail)
# RETURN : JSON of people for a specified mail
# EXAMPLE : /api/personneByMail/cedric.menanteau@epsi.fr
post '/api/personneByMail/:mail' do |mail|
    getPeopleByMail(mail)
end

# ROUTE : {GET}/api/personneById
# RETURN : JSON of informations about a personne
get '/api/personneById' do
    getPersonneById(params[:idPeople])
end
