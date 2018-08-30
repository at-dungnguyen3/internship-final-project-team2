# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
parent_cat_1 = Category.create!(name: 'Đồng hồ treo tường')
parent_cat_2 = Category.create!(name: 'Đồng hồ để bàn')

child_ids = []

5.times do
  child = Category.create!(name: Faker::Cat.name, categories_id: [parent_cat_1.id, parent_cat_2.id].sample)
  child_ids << child.id
end

20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123456',
    activated?: true,
    activated_at: Time.now,
    role: 0
  )
end
