# frozen_string_literal: true

require 'mysql2'
load 'requests/conf.rb'

def getNbrOfCourseInProposition
  request_object = OpenConnectBdd.query('SELECT COUNT(id_proposition) as countProposition FROM logs_proposition')
  hash = request_object.each(&:to_h)
  hash.to_json
end
