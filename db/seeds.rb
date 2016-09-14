# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

name  = "Admin"
email = "admin@gmail.org"
password = "password"
User.create!(name: name,
email: email,
is_admin: true,
password: "123456",
password_confirmation: "123456")

20.times do |n|
  name  = "User #{n}"
  email = "user-#{n}@gmail.org"
  password = "password"
  User.create!(name: name,
    email: email,
    is_admin: false,
    password: "123456",
    password_confirmation: "123456")
end

Category.create!(name: "20 words")
Category.create!(name: "30 words")
