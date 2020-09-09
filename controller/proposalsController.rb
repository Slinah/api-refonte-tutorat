# frozen_string_literal: true


load 'requests/proposals.rb'


# ROUTE : {GET}/bot/unclosedProposals
# RETURN : JSON of matière, unclosed proposals
get '/bot/unclosedProposals' do
  getUnclosedProposals
end