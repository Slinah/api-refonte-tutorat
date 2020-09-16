# frozen_string_literal: true

require 'securerandom'
load 'requests/conf.rb'

def generateArchive
    uuid = -> { return SecureRandom.uuid.upcase }
    query1 = OpenConnectBdd.query('SELECT id_cours, id_matiere, id_promo, date, commentaires, nbParticipants, duree FROM cours')
    query1.each_with_index do |row, idx|
        currentId = uuid.call
        query3 = OpenConnectBdd.prepare('INSERT INTO archive(id_archive, id_matiere, date, commentaires, nbParticipants, duree) VALUES(?, ?, ?, ?, ?, ?)')
        query3.execute(currentId, row['id_matiere'], row['date'], row['commentaires'], row['nbParticipants'], row['duree'])
        puts "--- INSERT ARCHIVE ENDED ID : #{currentId} ---"

        query2 = OpenConnectBdd.prepare('SELECT id_personne, rang_personne FROM personne_cours WHERE id_cours=?')
        query2 = query2.execute(row['id_cours'])
        query2.each do |row2|
            query4 = OpenConnectBdd.prepare('INSERT INTO personne_archive(id_personne, id_archive, rang_personne) VALUES(?, ?, ?)')
            query4.execute(row2['id_personne'], currentId, row2['rang_personne'])
            puts "--- INSERT PERSONNE_ARCHIVE ENDED ID : #{currentId} ---"

        end
        query5 = OpenConnectBdd.prepare('INSERT INTO archive_promo(id_archive, id_promo) VALUES(?, ?)')
        query5.execute(currentId, row['id_promo'])
        puts "--- INSERT ARCHIVE_PROMO ENDED ID : #{currentId} ---"

        query6 = OpenConnectBdd.prepare('DELETE FROM cours WHERE id_cours=?')
        query6.execute(row['id_cours'])
        puts "--- DELETE COURS ENDED ID : #{currentId} ---"

        query7 = OpenConnectBdd.prepare('DELETE FROM personne_cours WHERE id_cours=? AND id_personne=?')
        query7.execute(row['id_cours'], row['id_personne'])
        puts "--- DELETE PERSONNE_COURS ENDED ID : #{row['id_cours']} ---"

    end
end

generateArchive()