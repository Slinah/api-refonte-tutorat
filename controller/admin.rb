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