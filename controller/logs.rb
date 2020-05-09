# frozen_string_literal: true


load 'requests/logs.rb'


# ROUTE : {GET}/api/fromLogsGetLatestCourse
# RETURN : JSON of latest inserted course
get '/api/fromLogsGetLatestCourse' do
  getLatestCourseByLogs
end


# ROUTE : {DELETE}/api/deleteLogCourse/:idCourse
# PARAM : STRING id_cours
# RETURN : JSON of latest inserted course
# EXAMPLE : /api/deleteLogCourse/A7516064-F3FB-41BB-815C-A195DE9E92C9
delete '/api/unsetLogCourse/:idCourse' do |id_course|
  deleteLogCourseById(id_course)
end


# ROUTE : {GET}/api/fromLogsGetLatestProposal
# RETURN : JSON of latest inserted proposal
get '/api/fromLogsGetLatestProposal' do
  getLatestProposalByLogs
end


# ROUTE : {DELETE}/api/deleteLogProposal/:idProposal
# PARAM : STRING id_proposal
# RETURN : JSON of latest inserted proposal
# EXAMPLE : /api/deleteLogProposal/A7516064-F3FB-41BB-815C-A195DE9E92C9
delete '/api/unsetLogProposal/:idProposal' do |id_proposal|
  deleteLogProposalById(id_proposal)
end
