# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |n|
  email = Faker::Internet.email
  address = "mitaka"
  password = "password"
  tel = 1111111111
  User.create!(
               name: Faker::Name.first_name,
               address: address,
               email: email,
               tel: tel,
               password: password,
               password_confirmation: password
               )
end

#admin
User.create!(
  id:999,
  email: "yuta1111@gmail.com",
  name: "yuta",
  tel: 1111111111,
  address: "mitaka",
  password: "password",
  password_confirmation: "password",
  admin: true
)

200.times do |n|
  price = n
  description = "password"
  kinds = ["帽子","ズボン","シャツ","パンツ","T-シャツ","ワイシャツ","ポロシャツ","小物","靴","メガネ","カバン","上着"]
  kind = kinds.sample
  images = open("#{Rails.root}/db/fixtures/maikeru.jpg"),open("#{Rails.root}/db/fixtures/samune15.jpg"),open("#{Rails.root}/db/fixtures/shopping.jpeg")
  image = images.sample
  stock = 10
  Product.create!(
               name: Faker::Name.first_name,
               price: price,
               description: description,
               kind: kind,
               image: image,
               stock: stock
               )
end
