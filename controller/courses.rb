# frozen_string_literal: true


load 'requests/courses.rb'


get '/api/unclosedCourses' do
  getUnclosedCourses
end