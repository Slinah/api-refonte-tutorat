# frozen_string_literal: true


load 'requests/logs.rb'


# ROUTE : {GET}/bot/fromLogsGetLatestCourse
# RETURN : JSON of latest inserted course
get '/bot/fromLogsGetLatestCourse' do
  getLatestCourseByLogs
end


# ROUTE : {DELETE}/bot/unsetLogCourse/:idCourse
# PARAM : STRING id_cours
# RETURN : JSON of latest inserted course
# EXAMPLE : /bot/unsetLogCourse/A7516064-F3FB-41BB-815C-A195DE9E92C9
delete '/bot/unsetLogCourse/:idCourse' do |id_course|
  deleteLogCourseById(id_course)
end


# ROUTE : {GET}/bot/fromLogsGetLatestProposal
# RETURN : JSON of latest inserted proposal
get '/bot/fromLogsGetLatestProposal' do
  getLatestProposalByLogs
end


# ROUTE : {DELETE}/bot/deleteLogProposal/:idProposal
# PARAM : STRING id_proposal
# RETURN : JSON of latest inserted proposal
# EXAMPLE : /bot/deleteLogProposal/A7516064-F3FB-41BB-815C-A195DE9E92C9
delete '/bot/unsetLogProposal/:idProposal' do |id_proposal|
  deleteLogProposalById(id_proposal)
end
