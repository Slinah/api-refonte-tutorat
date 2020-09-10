# frozen_string_literal: true

require 'sinatra'
load 'controller/chartsController.rb'
load 'controller/coursesController.rb'
load 'controller/logsController.rb'
load 'controller/logsPropositionController.rb'
load 'controller/proposalsController.rb'
load 'controller/promoController.rb'
load 'controller/personneController.rb'

Sinatra::Application.environment == :development
