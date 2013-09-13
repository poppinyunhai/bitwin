# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#encoding : utf-8
q1 = Question.new
q1.description = "我的生日是？"
q1.save!

q2 = Question.new
q2.description = "我最喜欢的人的名字是？"
q2.save!


