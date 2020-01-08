# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |n|
  email = Faker::Internet.email
  address = "yamata90-100-300"
  password = "password"
  zip_code = 9099900
  prefectures = "福島県"
  tel = 1111111111
  sexes = [0,1].sample
  birthday = Date.today.strftime
  User.create!(
               name: Faker::Name.first_name,
               zip_code: zip_code,
               prefectures: prefectures,
               address: address,
               email: email,
               tel: tel,
               password: password,
               password_confirmation: password,
               sex: sexes,
               birthday: birthday
               )
end

#admin
User.create!(
  id:999,
  email: "yuta1111@gmail.com",
  name: "yuta",
  tel: 1111111111,
  address: "mitaka",
  zip_code: 1910099,
  prefectures: "福島県",
  password: "password",
  password_confirmation: "password",
  admin: true,
  sex: 0,
  birthday: Date.today.strftime
)

User.create!(
  id:1999,
  email: "yuta2222@gmail.com",
  name: "yuta",
  tel: 1111111111,
  address: "mitaka",
  zip_code: 1910099,
  prefectures: "福島県",
  password: "password",
  password_confirmation: "password",
  admin: false,
  sex: 1,
  birthday: Date.today.strftime
)

300.times do |n|
  price = n*100
  description = "password"
  kinds = ["帽子","ズボン","シャツ","パンツ","T-シャツ","ワイシャツ","ポロシャツ","小物","靴","メガネ","カバン","上着"]
  kind = kinds.sample
  images = open("#{Rails.root}/db/fixtures/maikeru.jpg"),open("#{Rails.root}/db/fixtures/samune15.jpg"),open("#{Rails.root}/db/fixtures/shopping.jpeg")
  image = images.sample
  stock = 30
  sizes = ["~XS","S","M","L","XL~"]
  size = sizes.sample
  Product.create!(
               name: Faker::Games::Pokemon.name,
               price: price,
               description: Faker::Lorem.sentence + Faker::Lorem.sentence + Faker::Lorem.sentence + Faker::Lorem.sentence,
               kind: kind,
               image: image,
               stock: stock,
               designer: Faker::Games::SuperSmashBros.fighter,
               sale: false,
               size: size
               )
end

50.times do |n|
  ids = n+10
  product_ids = n+10
  user_id = 1999
  Favorite.create!(
                id: ids,
                product_id: product_ids,
                user_id: user_id
                )
end
