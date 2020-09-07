# frozen_string_literal: true


require 'mysql2'
load 'requests/conf.rb'


def getForumQuestions
  request_object = OpenConnectBdd.query('SELECT q.titre, q.description,p.prenom,m.intitule,q.status,COUNT(v.id_vote)
as \'votes\',(SELECT Count(*) FROM question_forum LEFT JOIN comment on comment.id_question=question_forum.id_question
 WHERE question_forum.id_question=q.id_question ) as \'comments\' FROM `question_forum` as q join personne as p on
q.id_personne=p.id_personne join matiere as m on m.id_matiere=q.id_matiere LEFT join vote as v on v.id_question=q.id_question left JOIN `comment`
as c  on c.id_question=q.id_question GROUP BY q.id_question')
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Impossible d\'acceder aux questions.'
  else
    hash.to_json
  end
end


def getQuestion(id_question)
  request_object = OpenConnectBdd.prepare('SELECT * FROM `question_forum` WHERE id_question=?')
  request_object = request_object.execute(id_question)
  hash = request_object.each(&:to_h)
  if hash.length.zero?
    'Impossible d\'acceder au post'
  else
    hash.to_json
  end
end






























