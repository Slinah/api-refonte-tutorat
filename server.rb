# frozen_string_literal: true

require 'sinatra'
require 'mysql2'
require 'sinatra/cross_origin'

configure do
  enable :cross_origin
end
before do
  response.headers['Access-Control-Allow-Origin'] = 'http://workshop'
end

#routes
load './requests/conf.rb'
load './controller/forumController.rb'
load './controller/adminController.rb'
load './controller/chartsController.rb'
load './controller/coursesController.rb'
load './controller/logsController.rb'
load './controller/logsPropositionController.rb'
load './controller/proposalsController.rb'
load './controller/promoController.rb'
load './controller/personneController.rb'
load './controller/authentificationController.rb'
load './controller/matiereController.rb'
load './controller/archiveController.rb'

options "*" do
  response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

Sinatra::Application.environment == :development

puts "Started"

