# frozen_string_literal: true


load 'requests/courses.rb'


# ROUTE : {GET}/bot/unclosedCourses
# RETURN : JSON of Tuteur, matière, unclosed courses
get '/bot/unclosedCourses' do
  getUnclosedCourses
end


# ROUTE : {POST}/bot/peopleCourse
# PARAM : STRING -> lastname(nom) ~/~ STRING -> firstname(prénom)
# RETURN : JSON of courses for a specified people
# EXAMPLE : /bot/peopleCourse?lastname=Menanteau&firstname=Cédric
post '/bot/peopleCourse' do
  getCoursesOfASpecificUser(params[:lastname], params[:firstname])
end


# ROUTE : {POST}/bot/unclosedCoursesPromo
# PARAM : STRING -> name_promo(intitule promo)
# RETURN : JSON of courses for a specified promo
# EXAMPLE : /bot/unclosedCoursesPromo/B1
post '/bot/unclosedCoursesPromo/:name_promo' do |name_promo|
  getUnclosedCoursesByIntitule(name_promo)
end

# ROUTE : {GET}/bot/courseOfTheDay
# RETURN : JSON of intitule, heure, date, salle , matière, promo
get '/bot/getCourseOfTheDay' do
  getCourseOfTheDay
end

# ROUTE : {POST}/api/getOwnCourses
# PARAM : STRING -> ID personne
# RETURN : JSON of courses for a specified person when he's tutor of them
post '/api/getOwnCourses' do
  getOwnCourses(params[:idPersonne])
end

# ROUTE : {POST}/api/getRegisteredCourses
# PARAM : STRING -> ID personne
# RETURN : JSON of courses for a specified person when he's registered on them
post '/api/getRegisteredCourses' do
  getRegisteredCourses(params[:idPersonne])
end