# frozen_string_literal: true


load 'requests/proposals.rb'


# ROUTE : {GET}/api/unclosedCourses
# RETURN : JSON of Tuteur, matière, unclosed courses
get '/api/unclosedProposals' do
  getUnclosedProposals
end

