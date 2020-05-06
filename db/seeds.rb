puts 'create users'
admin = Admin.create!(user_name: "BinhPham",
                     email: "binh@gmail.com",
                     password: "123456",
                     role: "admin")

user = User.create!(user_name: "NinhPham",
                    email: "ninhpham@gmail.com",
                    password:    "123456",
                    password_confirmation: "123456",
                    full_name: "Georgio Armani",
                    phone_number: "0964980884",
                    address: "Thai Binh"
                    )

100.times do |n|
  user_name  = Faker::Name.name
  email = "ex-#{n+1}@gmail.com"
  password = "123456"
  User.create!(user_name: user_name,
                email: email,
                password: password,
                full_name: "Georgio Armani",
                phone_number: "0964980884",
                address: "Thai Binh"
               )
end

15.times do |n|
  lname  = Faker::Name.name
  quantity = Faker::Number.between(1, 10)
  price = Faker::Number.between(10, 200)
  description = Faker::Lorem.sentence(10)
  admin = Admin.first
  Product.create!(name:  lname,
                  quantity: quantity,
                  price: price,
                  description: description,
                  admin: admin)
end

50.times do |n|
  user = User.all.to_a.sample
  full_name = User.pluck(:full_name).to_a.sample
  address = Faker::Address.street_address
  phone_number = Faker::PhoneNumber.phone_number
  status = 0
  Order.create!(user: user,
               full_name: full_name,
               address: address,
               phone_number:  phone_number,
               status: status)
end 

orders = Order.order(:created_at).take(6)
5.times do |n|
  quantity = Faker::Number.between(1, 10)
  productid = Faker::Number.between(1, 15)
  orders.each { |order| order.order_items.create!(quantity: quantity, product_id: productid) } 
end

admins = Admin.all
30.times do |n|
  title = Faker::Lorem.sentence(10)
  content = Faker::Lorem.sentence(100)
  admins.each {|admin| admin.blogs.create!(title: title, content: content)}
end
