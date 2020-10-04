# frozen_string_literal: true


# load 'requests/conf.rb'

def isConnected(token)
  request_object = OpenConnectBdd.prepare('SELECT personne.role as \'check\' FROM `personne` WHERE token=?')
  request_object = request_object.execute(token)
  hash = request_object.each(&:to_h)
  print("Taille du tableau : " , hash.length )
  if hash.length.zero?
    {'check' => false}.to_json
  else
    {'check' => true}.to_json
  end
end

def isAdmin(token)
  request_object = OpenConnectBdd.prepare('SELECT personne.role as \'admin\' FROM `personne` WHERE token=? and personne.role=1')
  request_object = request_object.execute(token)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    {'admin' => false}.to_json
  else
    {'admin' => true}.to_json
  end
end

def connect(email)
  request_object = OpenConnectBdd.prepare('SELECT * FROM `personne` WHERE personne.mail = ?')
  request_object = request_object.execute(email)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    {'password' => false}.to_json
  else
    hash[0].to_json
  end
end

def createAccount(school, promo, classe, firstname, lastname, email, password)
  uuid = SecureRandom.uuid
  token = SecureRandom.uuid
  request_object = OpenConnectBdd.prepare('INSERT INTO `personne` (`id_personne`, `id_classe`, `nom`, `prenom`,  `password`, `mail`, `token` ) VALUES (?, ?, ?, ?, ?, ?, ?)')
  request_object.execute(uuid, classe, lastname, firstname, password, email, token)
  connect(email)
end






