# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

50.times do
  user = User.new(
    first_name: Faker::Name.name.split(" ")[0],
    last_name: Faker::Name.name.split(" ")[0],
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!

  company = Company.new(
    name: Faker::Company.name,
    city: Faker::Address.city,
    zip: Faker::Address.zip,
    state: Faker::Address.state_abbr,
    country: Faker::Address.country_code,
    description: Faker::Company.catch_phrase,
    website_url: Faker::Internet.domain_name,
    logo: Faker::Company.logo
  )
  company.user = user
  company.save!


end
users = User.all
