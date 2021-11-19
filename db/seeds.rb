# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "1", email: "user1@example.com", age: "under15", gender: "man", password:"password", password_confirmation: "password")
User.create!(name: "nao", email: "user2@example.com", age: "under15", gender: "man", password:"password", password_confirmation: "password")
#Content.create(title: "失敗", emotions: 1, score: 80, journaling: "ひどい" 
#  , situation: "上司に怒られた", compassion: "次頑張ろう！", status: 0)

# contents作成
user = User.find_by(name: "1")
emotions = 1
score = 80
status = 1

20.times do
  title = Faker::Lorem.sentence(word_count: 5)
  journaling = Faker::Lorem.sentence(word_count: 5)
  situation = Faker::Lorem.sentence(word_count: 5)
  compassion = Faker::Lorem.sentence(word_count: 5)
  user.contents.create!(title: title, emotions: emotions, score: score, journaling: journaling, situation: situation, compassion: compassion, status: status)
end

# イベント作成
user2 = User.find_by(name: "nao")
Event.create(user_id: user2.id, mind: 1, reason: "test", small_success: "test", date: "2021-11-23")
Event.create(user_id: user2.id, mind: 2, reason: "test", small_success: "test", date: "2021-11-19")
Event.create(user_id: user2.id, mind: 3, reason: "test", small_success: "test", date: "2021-11-20")
Event.create(user_id: user2.id, mind: 4, reason: "test", small_success: "test", date: "2021-11-21")
Event.create(user_id: user2.id, mind: 0, reason: "test", small_success: "test", date: "2021-11-22")
