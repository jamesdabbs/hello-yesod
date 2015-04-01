require 'faker'
require 'sequel'

require 'active_support/all' # for `days.ago`

DB = Sequel.connect('postgres://@localhost:5432/hello')
Users, Posts = DB[:user], DB[:post]

[Posts, Users].each &:delete

users = 15.times.map do
  Users.insert ident: Faker::Name.name, password: Faker::Internet.password
end

50.times do
  Posts.insert(
    author_id: users.sample,
    title:     Faker::Company.catch_phrase,
    body:      Faker::Lorem.paragraphs(rand 2..5).join("\n"),
    published_at: rand(1..7).days.ago
  )
end
