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

5.times do |i|
  child = Category.create!(name: "#{Faker::Cat.name} #{i}", categories_id: [parent_cat_1.id, parent_cat_2.id].sample)
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

20.times do
  Product.create!(
    name: Faker::Name.name,
    category_id: child_ids.sample,
    quantity: rand(10..50),
    price: 10000,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce malesuada sapien vitae tincidunt tristique. Aliquam vitae vestibulum ex. Mauris sagittis urna ut velit tristique maximus. Nullam at lacus nulla. Mauris condimentum nunc nunc, at finibus metus fermentum in. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae',
    detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce malesuada sapien vitae tincidunt tristique. Aliquam vitae vestibulum ex. Mauris sagittis urna ut velit tristique maximus. Nullam at lacus nulla. Mauris condimentum nunc nunc, at finibus metus fermentum in. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;

    Quisque porta augue risus, id dignissim nulla bibendum sit amet. Fusce et ornare arcu. In quis leo varius, pharetra felis et, interdum dolor. Nunc arcu dolor, eleifend id imperdiet a, iaculis et tellus. Suspendisse cursus diam ac condimentum auctor. Phasellus ac consequat urna. Maecenas sit amet congue quam. Vivamus luctus sapien vitae ligula ultricies efficitur. In in consequat ex.

    Vestibulum et tellus massa. Integer lectus nunc, malesuada at metus non, lobortis ultricies nisl. Vestibulum pharetra sapien sit amet massa euismod, et posuere turpis sagittis. Duis eleifend dignissim tempus. Nullam et nunc id velit dapibus pharetra eu sit amet nibh. Ut semper malesuada mollis. Maecenas velit lacus, rutrum eleifend lectus faucibus, suscipit fringilla metus. Ut tempor ante eros, id imperdiet magna consectetur vel. Quisque ut nibh sit amet dui ullamcorper hendrerit. Ut quis aliquam magna. Phasellus pellentesque pharetra dignissim. Aenean vitae leo lobortis, dapibus lacus in, aliquet nibh. Vestibulum fringilla ipsum vel sagittis ultricies.

    Sed finibus at ante vel gravida. Integer venenatis sem suscipit orci tempor elementum. Phasellus ut blandit tellus. Quisque rhoncus nulla eu urna aliquet accumsan. Etiam ac erat lorem. Fusce in lorem enim. Morbi lacinia interdum rutrum. Vivamus ac purus eget nisl condimentum suscipit et vitae sem. Aenean fermentum, neque non faucibus fermentum, tortor turpis malesuada tellus, sed aliquam arcu diam at orci. Ut faucibus nibh a velit commodo, et dignissim velit consequat. Maecenas sollicitudin dui sem, ac suscipit nisl euismod quis.

    Nulla facilisi. Phasellus sit amet mi sed tortor facilisis facilisis ut commodo justo. Cras varius imperdiet augue, nec blandit purus commodo vel. Curabitur ac maximus arcu. Nam aliquet orci eu ex vestibulum maximus. Praesent a nulla ut massa maximus volutpat. In mauris mi, iaculis ac fermentum semper, blandit vel dui. Donec velit arcu, pulvinar ac metus non, vehicula aliquet mi. Pellentesque pulvinar purus sed lacinia faucibus. Maecenas placerat iaculis finibus. Aenean vitae nisi ac erat blandit facilisis ac vel enim. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
  )
end
