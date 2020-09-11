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
  getCourseOfASpecificUser(params[:lastname], params[:firstname])
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

# ROUTE : {GET}/bot/getNbrOfCourse
# RETURN : JSON of count of id_cours
get '/bot/getNbrOfCourse' do
  getNbrOfCourse
end

# ROUTE : {GET}/bot/GetLatestcourse
# RETURN : JSON of id_promo, heure, date, id_matiere, intitule, salle
get '/bot/getLatestCourse' do
  getLatestCourse
end