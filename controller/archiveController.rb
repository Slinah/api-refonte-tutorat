# frozen_string_literal: true

load 'requests/admin.rb'

# Genere les archives a partir des données des tables cours et personne_cours
 put '/api/generateArchive' do
    generateArchive
end

