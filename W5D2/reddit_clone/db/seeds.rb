# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
50.times do
  username = Faker::RickAndMorty.character
  count = 0
  until User.find_by_username(username).nil?
    username = Faker::RickAndMorty.character
    break if count == 10
    count += 1
  end
  begin
    User.create(username: username, password: 'password')
  rescue
    next
  end
end

Sub.destroy_all
user_ids = User.all.map{|x| x.id}
20.times do
  title = Faker::RickAndMorty.location
  count = 0
  until Sub.find_by_title(title).nil?
    title = Faker::RickAndMorty.location
    break if count == 10
    count += 1
  end
  begin
    Sub.create(title: title, description: '', moderator_id: user_ids.sample )
  rescue
    next
  end
end
