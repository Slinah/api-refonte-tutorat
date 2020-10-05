# frozen_string_literal: true

# load 'requests/conf.rb'

def getPersonneById(idPeople)
  request_object = OpenConnectBdd.prepare('SELECT p.nom as nom, p.prenom as prenom, pro.intitule as intitulePromo,
p.id_personne as id_createur, pro.id_promo as id_promo from personne p join classe c on p.id_classe=c.id_classe
join promo pro on c.id_promo=pro.id_promo join ecole e on pro.id_ecole=e.id_ecole where id_personne=?;')
  request_object = request_object.execute(idPeople)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "L'id de cette personne n'est pas présente dans notre base de donnée !"}
    result.to_json
  else
    hash.to_json
  end
end


def vExistsPersonne(lastname, firstname)
  request_object = OpenConnectBdd.prepare('SELECT id_personne FROM personne WHERE nom=? AND prenom=?')
  request_object = request_object.execute(lastname, firstname)
  request_object.each(&:to_h)
end

def vExistsPersonneByMail(mail)
  request_object = OpenConnectBdd.prepare('SELECT COUNT(*) FROM personne WHERE mail=?')
  request_object = request_object.execute(mail)
  # request_object.each(&:to_h)
  # puts(request_object)
end

#fixme ???
def getPeopleByMail(mail)
  unless [nil, 0].include?(vExistsPersonne(mail)[0])
    # request_object = OpenConnectBdd.prepare()
    # request_object = request_object.execute(mail)
    # request_object.each(&:to_h)
  end
end

def getPeopleById(idPersonne)
  ro = OpenConnectBdd.prepare('SELECT ec.intitule as ecole, ppref.experience as experience, p.nom, p.prenom, p.role, p.mail, p.image, cl.intitule as intituleClasse,
pro.intitule as intitulePromo FROM personne p JOIN classe cl ON p.id_classe=cl.id_classe
JOIN promo pro ON cl.id_promo = pro.id_promo join ecole ec ON ec.id_ecole=pro.id_ecole join personne_preferences ppref on p.id_personne=ppref.id_personne WHERE p.id_personne = ?')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    result = {"error" => "Impossible de récupérer les informations du profil !"}
    result.to_json
  else
    hash[0].to_json
  end
end

def postPreferenceById(idPersonne, idCursor)
  ro = OpenConnectBdd.prepare('SELECT * FROM personne p JOIN personne_preferences ppref on p.id_personne=ppref.id_personne WHERE p.id_personne = ?')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    ro = OpenConnectBdd.prepare('SELECT * from personne where id_personne=?')
    ro = ro.execute(idPersonne)
    hash2 = ro.each(&:to_h)
    if hash2.length.zero?
      retourUser = {"error" => "l'utilisateur n'éxiste pas !"}
      retourUser.to_json
    else
      ro = OpenConnectBdd.prepare('INSERT INTO `personne_preferences` (`id_personne`,`curseur_id`) VALUES (?, ?);')
      ro.execute(idPersonne, idCursor)
      retourUser = {"success" => "Les préfèrences ont bien étés crées !"}
      retourUser.to_json
    end
  else
    ro = OpenConnectBdd.prepare('UPDATE personne_preferences pp SET pp.curseur_id = ? where pp.id_personne=?;')
    ro.execute(idCursor, idPersonne)
    retourUser = {"success" => "Les préfèrences ont bien étés modifiés !"}
    retourUser.to_json
  end
end

def getPreferenceById(idPersonne)
  ro = OpenConnectBdd.prepare('SELECT * FROM personne p JOIN personne_preferences ppref on p.id_personne=ppref.id_personne WHERE p.id_personne = ?')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  if hash.length.zero?
    ro = OpenConnectBdd.prepare('SELECT * from personne where id_personne=?')
    ro = ro.execute(idPersonne)
    hash2 = ro.each(&:to_h)
    if hash2.length.zero?
      retourUser = {"error" => "l'utilisateur n'éxiste pas !"}
      retourUser.to_json
    else
      ro = OpenConnectBdd.prepare('INSERT INTO `personne_preferences` (`id_personne`) VALUES (?);')
      ro.execute(idPersonne)
    end
  end
  ro = OpenConnectBdd.prepare('SELECT p.id_personne,p.nom,p.prenom,
      ppref.curseur_id,ppref.theme_id,ppref.experience FROM personne p JOIN personne_preferences ppref
      on p.id_personne=ppref.id_personne WHERE p.id_personne = ?')
  ro = ro.execute(idPersonne)
  hash = ro.each(&:to_h)
  hash.to_json
end
