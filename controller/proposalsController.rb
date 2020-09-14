# frozen_string_literal: true
load 'requests/proposals.rb'

# ROUTE : {GET}/bot/unclosedProposals
# RETURN : JSON of matière, unclosed proposals
get '/api/unclosedProposals' do
  getUnclosedProposals
end

# ROUTE : {GET}/bot/unclosedProposals
# RETURN : JSON of matière, unclosed proposals
get '/bot/unclosedProposals' do
  getUnclosedProposals
end

# Envoie d'une proposition dans la table (proposition)
# ROUTE : {POST}/api/sendProposalsCoursesPeople
# PARAM : STRING -> STRING id_proposition(uuid généré en php) ~/~ id_createur(id personne qui fait la proposition) ~/~ STRING -> id_matiere(id de la matière concernée)
# EXAMPLE : /api/sendProposalsCoursesPeople
post '/api/sendProposalsCoursesPeople' do
  postSendProposalCoursesPeople(params[:id_createur], params[:id_matiere], params[:commentaire])
end

# Envoie d'une proposition dans la table (proposition_promo)
# ROUTE : {POST}/api/sendProposalsCoursesPromo
# PARAM : STRING -> STRING id_proposition(uuid généré en php) ~/~ id_promo(id promo de la personne qui a fait la proposition)
# EXAMPLE : /api/sendProposalsCoursesPromo
post '/api/sendProposalsCoursesPromo' do
  postSendProposalCoursesPromo(params[:id_proposition], params[:id_promo])
end