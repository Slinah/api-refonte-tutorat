# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'


Bdd = Base.new
Bdd.init
OpenConnectBdd = Mysql2::Client.new(host: Bdd.host,
                                    database: Bdd.database,
                                    user: Bdd.user)
def getChartGlobalMat
  ro = OpenConnectBdd.query('SELECT m.id_matiere AS id_matiere, m.intitule AS matiere, SUM(c.duree) AS duree FROM cours c INNER JOIN matiere m ON c.id_matiere=m.id_matiere WHERE c.status=1 GROUP BY m.id_matiere, m.intitule ORDER BY SUM(c.duree) DESC')
  h = ro.each(&:to_h)
  h.to_json
end

def getChartGlobalPart
  ro = OpenConnectBdd.query('SELECT p.id_personne AS id_personne, p.nom AS nom, p.prenom AS prenom, po.promo AS promo, SUM(c.duree) AS duree FROM personne p INNER JOIN classe cl ON p.id_classe=cl.id_classe INNER JOIN promo po ON cl.id_promo=po.id_promo INNER JOIN personne_cours pc ON p.id_personne=pc.id_personne INNER JOIN cours c ON pc.id_cours=c.id_cours WHERE c.status=1 AND pc.rang_personne=1 GROUP BY p.id_personne, p.nom, p.prenom, po.promo ORDER BY SUM(c.duree) DESC')
  h = ro.each(&:to_h)
  h.to_json
end

def getHeuresMatiere(promo)
  ro = OpenConnectBdd.prepare('SELECT SUM(c.duree) AS duree, m.intitule AS matiere FROM cours c INNER JOIN matiere m ON c.id_matiere=m.id_matiere INNER JOIN cours_promo cp ON c.id_cours=cp.id_cours INNER JOIN promo po ON cp.id_promo=po.id_promo WHERE c.status=1 AND po.promo=? GROUP BY m.intitule ORDER BY SUM(c.duree) DESC')
  ro = ro.execute(promo)
  h = ro.each(&:to_h)
  h.to_json
end

def getPartInsc(promo)
  ro = OpenConnectBdd.prepare('SELECT DATE_FORMAT(c.date, "%d %M %Y") AS date, m.intitule AS matiere, c.nbInscrits AS inscrits, c.nbParticipants AS participants, p.promo AS niveau FROM cours c JOIN matiere m ON c.id_matiere=m.id_matiere JOIN cours_promo cp ON c.id_cours=cp.id_cours JOIN promo p ON cp.id_promo=p.id_promo WHERE p.promo = ? AND c.status > 0 ORDER BY c.date ASC')
  ro = ro.execute(promo)
  h = ro.each(&:to_h)
  h.to_json
end

def getPartMois(promo)
  ro = OpenConnectBdd.prepare('SELECT SUM(c.nbParticipants) AS participants, MONTH(c.date) AS mois FROM cours c INNER JOIN cours_promo cp ON c.id_cours=cp.id_cours INNER JOIN promo po ON cp.id_promo=po.id_promo WHERE c.status=1 AND po.promo=? GROUP BY MONTH(c.date) ORDER BY MONTH(c.date)')
  ro = ro.execute(promo)
  h = ro.each(&:to_h)
  h.to_json
end

def getPercentMat(promo)
  ro = OpenConnectBdd.prepare('SELECT m.intitule AS matiere, SUM(c.nbParticipants) AS participants FROM cours c INNER JOIN matiere m ON c.id_matiere=m.id_matiere INNER JOIN cours_promo cp ON c.id_cours=cp.id_cours INNER JOIN promo po ON cp.id_promo=po.id_promo WHERE c.status=1 AND po.promo=? GROUP BY m.intitule')
  ro = ro.execute(promo)
  h = ro.each(&:to_h)
  h.to_json
end
