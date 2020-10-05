# frozen_string_literal: true


load 'requests/forum.rb'


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


# RETURN : JSON of Tuteur, matière, unclosed courses
get '/api/getCommentaireReply/:id_comment' do |id_comment|
  headers 'Access-Control-Allow-Origin' => 'http://localhost:4567'
  getComentaireReply(id_comment)
end

post '/api/upvoteQuestion' do
  upvoteQuestion(params[:id_personne], params[:id_question])
end


# ROUTE : {POST}/bot/peopleCourse
# PARAM : STRING -> lastname(nom) ~/~ STRING -> firstname(prénom)
# RETURN : JSON of courses for a specified people
# EXAMPLE : /bot/peopleCourse?lastname=Menanteau&firstname=Cédric
post '/api/postComQuestion' do
  postComQuestion(params[:id_personne], params[:content], params[:id_question])
end

# ROUTE : {POST}/bot/peopleCourse
# PARAM : STRING -> lastname(nom) ~/~ STRING -> firstname(prénom)
# RETURN : JSON of courses for a specified people
# EXAMPLE : /bot/peopleCourse?lastname=Menanteau&firstname=Cédric
post '/api/replyComQuestion' do
  replyComQuestion(params[:id_personne], params[:content], params[:id_comment])
end

