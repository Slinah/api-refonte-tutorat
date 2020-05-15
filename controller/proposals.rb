# frozen_string_literal: true


load 'requests/proposals.rb'


# ROUTE : {GET}/api/unclosedProposals
# RETURN : JSON of matière, unclosed proposals
get '/api/unclosedProposals' do
  getUnclosedProposals
end

