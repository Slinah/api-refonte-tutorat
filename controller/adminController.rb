# frozen_string_literal: true

load 'requests/admin.rb'

# Controller Admin : Toutes les routes nécessaires au panel administrateur du site.


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

#ROUTE : {POST}/deleteSubject
# PARAM : STRING -> ID Subject
post '/api/deleteSubject' do
  postDeleteSubject(params[:idSubject])
end

# ROUTE : {POST}/addSchool
# PARAM : STRING -> Intitule of the school
# RETURN : X
post '/api/addSchool' do
  postAddSchool(params[:intitule])
end

# ROUTE : {POST}/deleteSchool
# PARAM : STRING -> ID of the school
post '/api/deleteSchool' do
  postDeleteSchool(params[:idSchool])
end

# ROUTE : {POST}/addPromo
# PARAM1 : STRING -> ID of the school of promo
# PARAM2 : STRING -> intitule of the promo
post '/api/addPromo' do
  postAddPromo(params[:idSchool], params[:intitule])
end

# ROUTE : {POST}/deletePromo
# PARAM : STRING -> ID of the promo
post '/api/deletePromo' do
  postDeletePromo(params[:idPromo])
end

# ROUTE : {POST}/addClass
# PARAM1 : STRING -> Intitule of the class
# PARAM2 : STRING -> ID of the promo of the class
post '/api/addClass' do
  postAddClass(params[:intitule], params[:idPromo])
end

# ROUTE : {POST}/deleteClass
# PARAM : STRING -> ID of the class
post '/api/deleteClass' do
  postDeleteClass(params[:idClass])
end

# ROUTE : {POST}/addLevel
# PARAM : STRING -> Intitule of the level
# RETURN : X
post '/api/addLevel' do
  postAddLevel(params[:intitule])
end

# ROUTE : {POST}/deleteLevel
# PARAM : STRING -> ID of the level
post '/api/deleteLevel' do
  postDeleteLevel(params[:idLevel])
end

#ROUTE : {GET}/getAllUsers
# RETURN : JSON -> of all users
get '/api/getAllUsers' do
  getAllUsers
end

# ROUTE : {GET}/getAllSubjects
# RETURN : JSON -> of all subjects
get '/api/getAllSubjects' do
  getAllSubjects
end

# ROUTE : {GET}/getAllSchools
# RETURN : JSON -> of all schools
get '/api/getAllSchools' do
  getAllSchools
end

# ROUTE : {GET}/getPromoFromSchool
# RETURN : JSON -> of promo from a school
get '/api/getPromoFromSchool' do
  getPromoFromSchool
end

# ROUTE : {GET}/getClassFromPromo
# RETURN : JSON -> of class from a promo
get '/api/getClassFromPromo' do
  getClassFromPromo
end

#ROUTE : {GET}/getLevel
# RETURN : JSON -> of all level
get '/api/getLevel' do
  getLevel
end