# frozen_string_literal: true


load 'requests/forum.rb'


#
#  Liste des question par ordre chronologique
#   (possibilite de trie par nombre de vote)
# Il faut donc une func qui recup la liste des question : / Titre, content, autheur, matiere, nb de vote , nb de com, ouverte ou resolu /
# puis quand clique sur un post :
# acces au details des commentaire avec possibilité de repondre
#


# ROUTE : {GET}/bot/unclosedCourses
# RETURN : JSON of Tuteur, matière, unclosed courses
get '/api/getForumQuestions' do
  getForumQuestions
end


# RETURN : JSON of Tuteur, matière, unclosed courses
get '/api/getQuestion/:id_question' do |id_question|
  getQuestion(id_question)
end


# ROUTE : {POST}/bot/peopleCourse
# PARAM : STRING -> lastname(nom) ~/~ STRING -> firstname(prénom)
# RETURN : JSON of courses for a specified people
# EXAMPLE : /bot/peopleCourse?lastname=Menanteau&firstname=Cédric
post '/api/createForumQuestion' do
  createForumQuestion(params[:titre], params[:description], params[:id_personne], params[:id_matiere])
end


# RETURN : JSON of Tuteur, matière, unclosed courses
get '/api/getMatiere' do
  getMatiere
end


# RETURN : JSON of Tuteur, matière, unclosed courses
get '/api/getCommentaire/:id_question' do |id_question|
  getComentaire(id_question)
end







# ROUTE : {POST}/bot/peopleCourse
# PARAM : STRING -> lastname(nom) ~/~ STRING -> firstname(prénom)
# RETURN : JSON of courses for a specified people
# EXAMPLE : /bot/peopleCourse?lastname=Menanteau&firstname=Cédric
post '/api/postComQuestion' do
  getCourseOfASpecificUser(params[:lastname], params[:firstname])
end

# ROUTE : {POST}/bot/peopleCourse
# PARAM : STRING -> lastname(nom) ~/~ STRING -> firstname(prénom)
# RETURN : JSON of courses for a specified people
# EXAMPLE : /bot/peopleCourse?lastname=Menanteau&firstname=Cédric
post '/api/replyComQuestion' do
  getCourseOfASpecificUser(params[:lastname], params[:firstname])
end
