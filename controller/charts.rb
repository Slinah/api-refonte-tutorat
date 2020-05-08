# frozen_string_literal: true


load 'requests/charts.rb'


# ROUTE : {GET}/globalMatiere
# RETURN : JSON of Hours by Matiere
get '/api/globalMatiere' do
  getChartGlobalMat
end

# ROUTE : {GET}/globalParticipation
# RETURN : JSON of Participation by Matiere
get '/api/globalParticipation' do
  getChartGlobalPart
end

# ROUTE : {GET}/promoHeuresMatieres/{intitulePromo}
# PARAM : STRING -> Intitule Promo
# RETURN : JSON of Hours by Matiere and by Promo
get '/apipromoHeuresMatieres/:intitule' do |i|
  getHeuresMatiere(i)
end

# ROUTE : {GET}/promoPartInsc/{intitulePromo}
# PARAM : STRING -> Intitule Promo
# RETURN : JSON of Inscriptions and Participations by Promo
get '/api/promoPartInsc/:intitule' do |i|
  getPartInsc(i)
end

# ROUTE : {GET}/promoPartMois/{intitulePromo}
# PARAM : STRING -> Intitule Promo
# RETURN : JSON of Participation by Month by Promo
get '/api/promoPartMois/:intitule' do |i|
  getPartMois(i)
end

# ROUTE : {GET}/promoPercentMat/{intitulePromo}
# PARAM : STRING -> Intitule Promo
# RETURN : JSON of Percent Participation by Promo
get '/api/promoPercentMat/:intitule' do |i|
  getPercentMat(i)
end
