# frozen_string_literal: true

require 'sinatra'
load "requests/select.rb"

Sinatra::Application.environment == :production

get '/users' do
  getUsers
end
