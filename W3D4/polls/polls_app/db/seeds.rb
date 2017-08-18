# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

u1 = User.create!(username: "Nadine")
u2 = User.create!(username: "Jeff")
u3 = User.create!(username: "Alexa")
u4 = User.create!(username: "Jodi")
u5 = User.create!(username: "Togo")
u6 = User.create!(username: "Andre")

p1 = Poll.create!(title: 'More sandwiches!', author_id: u1.id)

q1 = Question.create!(text: "Do we need more sandwiches?", poll_id: p1.id)
q2 = Question.create!(text: "Do we need fewer sandwiches?", poll_id: p1.id)

ac1 =AnswerChoice.create!(text: "We need a lot more sandwiches to blah blah blah...", question_id: q1.id)
ac2 = AnswerChoice.create!(text: "We need a lot more lunch meat blah blah blah...", question_id: q1.id)
ac3 = AnswerChoice.create!(text: "We need a lot more bread to blah blah blah...", question_id: q1.id)
AnswerChoice.create!(text: "We need a lot more mustard to blah blah blah...", question_id: q1.id)
AnswerChoice.create!(text: "I hate all bread-based food, so blah blah blah...", question_id: q2.id)
AnswerChoice.create!(text: "You must loathe all food you eat with your hands blah blah blah...", question_id: q2.id)

Response.create!(user_id: u1.id, answer_choice_id: ac3.id)
Response.create!(user_id: u2.id, answer_choice_id: ac1.id)
Response.create!(user_id: u3.id, answer_choice_id: ac2.id)
