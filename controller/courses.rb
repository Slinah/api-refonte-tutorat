# frozen_string_literal: true


load 'requests/courses.rb'


# ROUTE : {GET}/api/unclosedCourses
# RETURN : JSON of Tuteur, matière, unclosed courses
get '/api/unclosedCourses' do
  getUnclosedCourses
end


# ROUTE : {POST}/api/peopleCourse
# PARAM : STRING -> lastname(nom) ~/~ STRING -> firstname(prénom)
# RETURN : JSON of courses for a specified people
# EXAMPLE : /api/peopleCourse?lastname=Menanteau&firstname=Cédric
post '/api/peopleCourse' do
  getCourseOfASpecificUser(params[:lastname], params[:firstname])
end


# ROUTE : {POST}/api/unclosedCoursesPromo
# PARAM : STRING -> name_promo(intitule promo)
# RETURN : JSON of courses for a specified promo
# EXAMPLE : /api/unclosedCoursesPromo/B1
post '/api/unclosedCoursesPromo/:name_promo' do |name_promo|
  getUnclosedCoursesByIntitule(name_promo)
end

