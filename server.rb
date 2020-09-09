# frozen_string_literal: true

require 'sinatra'


load 'controller/chartsController.rb'
load 'controller/coursesController.rb'
load 'controller/logsController.rb'
load 'controller/proposalsController.rb'
load 'controller/promoController.rb'
load 'controller/personneController.rb'
load 'controller/forumController.rb'
load 'controller/adminController.rb'


Sinatra::Application.environment == :development
