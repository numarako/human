# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "1", email: "user1@example.com", age: "under15", gender: "man", password:"password", password_confirmation: "password")
User.create!(name: "nao", email: "user2@example.com", age: "under15", gender: "man", password:"password", password_confirmation: "password")

# contents作成
user = User.find_by(name: "1")
user2 = User.find_by(name: "nao")
emotions = 1
score = 80
status = 1

20.times do
  title = Faker::Lorem.sentence(word_count: 10)
  journaling = Faker::Lorem.sentence(word_count: 100)
  situation = Faker::Lorem.sentence(word_count: 100)
  compassion = Faker::Lorem.sentence(word_count: 100)
  user.contents.create!(title: title, emotions: emotions, score: score, journaling: journaling, situation: situation, compassion: compassion, status: status)
  user2.contents.create!(title: title, emotions: emotions, score: score, journaling: journaling, situation: situation, compassion: compassion, status: status)
end

# イベント作成
Event.create(user_id: user.id, mind: 1, reason: "test", small_success: "test", small_thanks: "test", date: "2021-11-23")
Event.create(user_id: user.id, mind: 2, reason: "test", small_success: "test", small_thanks: "test",date: "2021-11-19")
Event.create(user_id: user.id, mind: 3, reason: "test", small_success: "test", small_thanks: "test",date: "2021-11-20")
Event.create(user_id: user.id, mind: 4, reason: "test", small_success: "test", small_thanks: "test",date: "2021-11-21")
Event.create(user_id: user.id, mind: 0, reason: "test", small_success: "test", small_thanks: "test",date: "2021-11-22")
Event.create(user_id: user2.id, mind: 1, reason: "test", small_success: "test", small_thanks: "test", date: "2021-11-23")
Event.create(user_id: user2.id, mind: 2, reason: "test", small_success: "test", small_thanks: "test",date: "2021-11-19")
Event.create(user_id: user2.id, mind: 3, reason: "test", small_success: "test", small_thanks: "test",date: "2021-11-20")
Event.create(user_id: user2.id, mind: 4, reason: "test", small_success: "test", small_thanks: "test",date: "2021-11-21")
Event.create(user_id: user2.id, mind: 0, reason: "test", small_success: "test", small_thanks: "test",date: "2021-11-22")

# お気に入り作成
10.times do
  content_id = rand(1..40)
  if content_id%2 == 0
    user.content_bookmarks.create(content_id: content_id)
  else
    user2.content_bookmarks.create(content_id: content_id)
  end
end

# 自己メモ追加
20.times do
  category = rand(0..3)
  title = Faker::Lorem.sentence(word_count: 10)
  text = Faker::Lorem.sentence(word_count: 100)
  user.memos.create!(title: title, text: text, category: category)
  user2.memos.create!(title: title, text: text, category: category)
end
