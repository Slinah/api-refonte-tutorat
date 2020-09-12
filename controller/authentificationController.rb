# frozen_string_literal: true


load 'requests/authentication.rb'


# # ROUTE : {GET}/bot/unclosedCourses
# # RETURN : JSON of Tuteur, matière, unclosed courses
# get '/api/getForumQuestions' do
#   getForumQuestions
# end
#
#
# # RETURN : JSON of Tuteur, matière, unclosed courses
# get '/api/getQuestion/:id_question' do |id_question|
#   getQuestion(id_question)
# end
#
#
# # ROUTE : {POST}/bot/peopleCourse
# # PARAM : STRING -> lastname(nom) ~/~ STRING -> firstname(prénom)
# # RETURN : JSON of courses for a specified people
# # EXAMPLE : /bot/peopleCourse?lastname=Menanteau&firstname=Cédric
# post '/api/createForumQuestion' do
#   createForumQuestion(params[:titre], params[:description], params[:id_personne], params[:id_matiere])
# end
# headers 'Access-Control-Allow-Origin' => 'http://tutorat-workshop'



post '/api/isConnected' do
  isConnected(params[:token])
end


post '/api/isAdmin' do
  isAdmin(params[:token])
end


post '/api/connect' do
  connect(params[:email])
end


post '/api/createAccount' do
  createAccount(params[:school],params[:promo],params[:firstname],params[:lastname],params[:email],params[:password])
end




