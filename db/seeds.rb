# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Exercise.delete_all
# rudiments = Exercise.create(
#     [{name: 'Single Stroke Roll', sticking: 'RLRLRLRLRL', id: 1}, 
#     {name: 'Single Stroke Four', sticking: 'RLRL RLRL', id: 2},
#     {name: 'Single Stroke Seven', sticking: 'RLRLRLR', id: 3}, 
#     {name: 'Multiple Bounce Roll', id: 4}])

Exercise.delete_all
f = File.read(Rails.root + "lib/rudiments.json")
rudiments = JSON.parse f
Exercise.create!(rudiments)

User.delete_all
User.create!(id: 1,  name: "Chris Jewell", email: "chrisjohnjewell@gmail.com", 
             password: "password", password_confirmation: "password")

User.first.assign_new_daily
             
Scorecard.delete_all
Scorecard.create!(user_id: 1, exercise_id: 1, score4: 120)
Scorecard.create!(user_id: 1, exercise_id: 2, score4: 140)
