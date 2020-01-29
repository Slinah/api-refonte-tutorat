# frozen_string_literal: true

require 'sinatra'
load 'requests/select.rb'

Sinatra::Application.environment == :production

get '/globalMatiere' do
  getChartGlobalMat
end

get '/globalParticipation' do
  getChartGlobalPart
end

get '/promoHeuresMatieres/:intitule' do |i|
  getHeuresMatiere(i)
end

get '/promoPartInsc/:intitule' do |i|
  getPartInsc(i)
end

get '/promoPartMois/:intitule' do |i|
  getPartMois(i)
end

get '/promoPercentMat/:intitule' do |i|
  getPercentMat(i)
end
