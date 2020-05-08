# frozen_string_literal: true

require 'sinatra'
load 'requests/select.rb'

Sinatra::Application.environment == :production

# ROUTE : {GET}/globalMatiere
# RETURN : JSON of Hours by Matiere
get '/globalMatiere' do
  getChartGlobalMat
end

# ROUTE : {GET}/globalParticipation
# RETURN : JSON of Participation by Matiere
get '/globalParticipation' do
  getChartGlobalPart
end

# ROUTE : {GET}/promoHeuresMatieres/{intitulePromo}
# PARAM : STRING -> Intitule Promo
# RETURN : JSON of Hours by Matiere and by Promo
get '/promoHeuresMatieres/:intitule' do |i|
  getHeuresMatiere(i)
end

# ROUTE : {GET}/promoPartInsc/{intitulePromo}
# PARAM : STRING -> Intitule Promo
# RETURN : JSON of Inscriptions and Participations by Promo
get '/promoPartInsc/:intitule' do |i|
  getPartInsc(i)
end

# ROUTE : {GET}/promoPartMois/{intitulePromo}
# PARAM : STRING -> Intitule Promo
# RETURN : JSON of Participation by Month by Promo
get '/promoPartMois/:intitule' do |i|
  getPartMois(i)
end

# ROUTE : {GET}/promoPercentMat/{intitulePromo}
# PARAM : STRING -> Intitule Promo
# RETURN : JSON of Percent Participation by Promo
get '/promoPercentMat/:intitule' do |i|
  getPercentMat(i)
end

get '/unclosedCourses' do
  getUnclosedCourses
end