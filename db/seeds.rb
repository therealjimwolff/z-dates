User.create!(name:  "Example User",
             email: "user@example.com",
             password:              "foobar",
             password_confirmation: "foobar")

65.times do |n|
  name  = Faker::Name.name
  email = "user-#{n + 1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Posts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.paragraph(4)
  users.each { |user| user.posts.create!(content: content) }
end

# Friends
users = User.all
user  = users.first
friends = users[2..50]
friends.each { |friend| user.friends << friend }
