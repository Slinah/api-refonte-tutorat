# frozen_string_literal: true


load 'requests/admin.rb'

# promoteAdmin & demoteAdmin --> réunir en une seule requête avec un query params ?

# ROUTE : {POST}/api/promoteAdmin
# PARAM : STRING -> ID Personne
# RETURN : X
# EXAMPLE : /api/promoteAdmin?idPersonne=A10
post '/api/promoteAdmin' do
  postPromoteAdmin(params[:idPersonne])
end

# ROUTE : {POST}/demoteAdmin
# PARAM : STRING -> ID Personne
# RETURN : X
post '/api/demoteAdmin' do
  postDemoteAdmin(params[:idPersonne])
end

# ROUTE : {POST}/deleteAccount
# PARAM : STRING -> ID Personne
# RETURN : X
post '/api/deleteAccount' do
  postDeleteAccount(params[:idPersonne])
end

# ROUTE : {POST}/addSubject
# PARAM : STRING -> Intitule of the subject
# RETURN : X
post '/api/addSubject' do
  postAddSubject(params[:intitule])
end

# ROUTE : {POST}/addSchool
# PARAM : STRING -> Intitule of the school
# RETURN : X
post '/api/addSchool' do
  postAddSchool(params[:intitule])
end

# ROUTE : {POST}/addClass
# PARAM : STRING -> Intitule of the class
# RETURN : X
post '/api/addClass' do
  postAddClass(params[:intitule])
end

# ROUTE : {POST}/addLevel
# PARAM : STRING -> Intitule of the level
# RETURN : X
post '/api/addLevel' do
  postAddLevel(params[:intitule])
end