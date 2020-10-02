# frozen_string_literal: true


# load 'requests/conf.rb'


def isConnected(token)
  request_object = OpenConnectBdd.prepare('SELECT count(*) as \'check\' FROM `personne` WHERE token=?')
  request_object = request_object.execute(token)
  hash = request_object.each(&:to_h)
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


#
# def getForumQuestions
#   request_object = OpenConnectBdd.query('SELECT q.titre,q.date,q.id_question, q.description,p.prenom,m.intitule,q.status,COUNT(v.id_vote) as \'votes\', (SELECT Count(comment.id_comment) FROM question_forum LEFT JOIN comment on comment.id_question=question_forum.id_question WHERE question_forum.id_question=q.id_question ) as \'comments\' FROM `question_forum` as q join personne as p on q.id_personne=p.id_personne join matiere as m on m.id_matiere=q.id_matiere LEFT join vote as v on v.id_question=q.id_question left JOIN `comment` as c on c.id_question=q.id_question GROUP BY q.id_question order by q.date DESC ')
#   hash = request_object.each(&:to_h)
#   if hash.length.zero?
#     'Impossible d\'acceder aux questions.'
#   else
#     hash.to_json
#   end
# end
#
#
# def getQuestion(id_question)
#   request_object = OpenConnectBdd.prepare('SELECT q.titre,q.date,q.id_question, q.description,p.prenom,m.intitule,
# q.status,COUNT(v.id_vote) as \'votes\',(SELECT Count(comment.id_comment) FROM question_forum LEFT JOIN comment on comment.id_question=question_forum.id_question
#  WHERE question_forum.id_question=q.id_question ) as \'comments\' FROM `question_forum` as q join personne as p on q.id_personne=p.id_personne
#  join matiere as m on m.id_matiere=q.id_matiere LEFT join vote as v on v.id_question=q.id_question left JOIN `comment` as c on c.id_question=q.id_question
#  WHERE q.id_question=?')
#   request_object = request_object.execute(id_question)
#   hash = request_object.each(&:to_h)
#   if hash.length.zero?
#     ' Impossible d \' acceder au post '
#   else
#     hash.to_json
#   end
# end
#
#
# def createForumQuestion(titre, description, id_personne, id_matiere)
#   uuid = SecureRandom.uuid
#   request_object = OpenConnectBdd.prepare(' INSERT INTO `question_forum` (`id_question`, `titre`, `description`,
#         `id_personne`, `id_matiere`) VALUES (?, ?, ?, ?, ?); ')
#   request_object.execute(uuid, titre, description, id_personne, id_matiere)
# end
#
#
# def getMatiere
#   request_object = OpenConnectBdd.query(' SELECT * FROM `matiere` where validationAdmin = 1 ')
#   hash = request_object.each(&:to_h)
#   if hash.length.zero?
#     ' Impossible d \' acceder aux matieres '
#   else
#     hash.to_json
#   end
# end
#
#
# def getComentaire(id_question)
#   request_object = OpenConnectBdd.prepare('SELECT comment.id_comment,comment.contenu,comment.dateCreation,personne.nom,personne.prenom, (SELECT COUNT(c.id_comment) from comment as c WHERE comment.id_comment=c.id_com) as \'sub\' FROM `comment` JOIN personne on personne.id_personne=comment.id_personne WHERE id_question=? order by comment.dateCreation DESC ')
#   request_object = request_object.execute(id_question)
#   hash = request_object.each(&:to_h)
#   if hash.length.zero?
#     ' Impossible d \' acceder aux matieres '
#   else
#     hash.to_json
#   end
# end
#
#
# def getComentaireReply(id_comment)
#   request_object = OpenConnectBdd.prepare('SELECT comment.id_comment,comment.contenu,comment.dateCreation,personne.nom,personne.prenom, (SELECT COUNT(c.id_comment) from comment as c WHERE comment.id_comment=c.id_com) as \'sub\' FROM `comment` JOIN personne on personne.id_personne=comment.id_personne WHERE id_com=? order by comment.dateCreation DESC ')
#   request_object = request_object.execute(id_comment)
#   hash = request_object.each(&:to_h)
#   if hash.length.zero?
#     ' Impossible d \' acceder aux matieres '
#   else
#     hash.to_json
#   end
# end
#
#
# def upvoteQuestion(id_personne, id_question)
#   request_object = OpenConnectBdd.prepare('select * from vote where id_personne=? and id_question=?;')
#   request_object = request_object.execute(id_personne, id_question)
#   hash = request_object.each(&:to_h)
#   print(hash)
#   if hash.length.zero?
#     uuid = SecureRandom.uuid
#     request_object = OpenConnectBdd.prepare('INSERT INTO `vote` (`id_vote`, `id_personne`, `id_question`) VALUES (?, ? , ? );')
#     request_object.execute(uuid, id_personne, id_question)
#   end
# end
#
#
# def postComQuestion(id_personne, content, id_question)
#   uuid = SecureRandom.uuid
#   request_object = OpenConnectBdd.prepare('INSERT INTO `comment` (`id_comment`, `contenu`, `id_question`, `id_personne`) VALUES (?, ?, ?, ?);')
#   request_object.execute(uuid, content, id_question, id_personne)
# end
#
#
# def replyComQuestion(id_personne, content, id_comment)
#   uuid = SecureRandom.uuid
#   request_object = OpenConnectBdd.prepare('INSERT INTO `comment` (`id_comment`, `contenu`, `id_com`, `id_personne`) VALUES (?, ?, ?, ?);')
#   request_object.execute(uuid, content, id_comment, id_personne)
# end
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#







