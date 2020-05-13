# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Deleting all users'
User.destroy_all
puts 'Deleting all posts'
Post.delete_all
puts 'Deleting all comments'
Comment.delete_all

User.create!(username: 'Ades', email: 'ades@gmail.com',
             password: 'foobar', password_confirmation: 'foobar')
50.times do |n|
  username = Faker::Name.first_name
  email = Faker::Internet.email(name: username)
  password = 'foobar'
  password_confirmation = 'foobar'

  puts "creating user ##{n}"
  User.create!(username: username, email: email, password: password,
               password_confirmation: password_confirmation)
end

50.times do |i|
  puts "Creating post ##{i}"
  post = Faker::Quote.famous_last_words
  user_id = User.all.ids.sample
  Post.create!(content: post, user_id: user_id)
end
25.times do |i|
  puts "Creating comment ##{i}"
  post = Post.all.ids.sample
  user = User.all.ids.sample
  comment = Faker::Quote.most_interesting_man_in_the_world
  Comment.create!(content: comment, user_id: user, post_id: post)
end
