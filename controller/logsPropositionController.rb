# frozen_string_literal: true


load 'requests/logsProposition.rb'

# ROUTE : {GET}/bot/getNbrOfCourseInProposition
# RETURN : JSON of count of id_proposition
get '/bot/getNbrOfCourseInProposition' do
  getNbrOfCourseInProposition
end