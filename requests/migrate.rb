# frozen_string_literal: true

require 'securerandom'
# load 'requests/conf.rb'

def migrateArchive
    uuid = -> { return SecureRandom.uuid.upcase }
    querySel = OpenConnectBdd.query('SELECT id_cours, id_matiere, id_promo, date, commentaires, nbParticipants, duree FROM cours')
    querySel.each_with_index do |row|
        id = uuid.call
        queryIns = OpenConnectBdd.prepare('INSERT INTO archive(id_archive, id_matiere, date, commentaires, nbParticipants, duree) VALUES(?, ?, ?, ?, ?, ?)')
        queryIns.execute(id, row['id_matiere'], row['date'], row['commentaires'], row['nbParticipants'], row['duree'])
        queryIns2 = OpenConnectBdd.prepare('INSERT INTO archive_promo(id_archive, id_promo) VALUES(?, ?)')
        queryIns2.execute(id, row['id_promo'])
        querySel2 = OpenConnectBdd.query('SELECT id_personne, id_cours, rang_personne FROM personne_cours')
        querySel2.each_with_index do |row2|
            queryIns3 = OpenConnectBdd.prepare('INSERT INTO personne_archive(id_personne, id_archive, rang_personne) VALUES(?, ?, ?)')
            queryIns3.execute(row2['id_personne'], id, row2['rang_personne'])
            queryDel = OpenConnectBdd.prepare('DELETE FROM personne_cours WHERE id_cours = ?')
            queryDel.execute(row['id_cours'])
            queryDel2 = OpenConnectBdd.prepare('DELETE FROM cours WHERE id_cours = ?')
            queryDel2.execute(row['id_cours'])
        end
    end
end
