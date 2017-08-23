# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
Cat.destroy_all

# 100.times do
#   c = Cat.new(birth_date: Faker::Date.between(20.years.ago, Date.today),
#     color: %w(orange blue green taco).sample,
#     name: Faker::RickAndMorty.character, sex: %w(M F).sample,
#     description: Faker::RickAndMorty.quote)
#
#   if c.valid?
#     c.save
#   else
#     next
#   end
# # end

c1 = Cat.create(birth_date: Faker::Date.between(20.years.ago, Date.today),
  color: %w(orange blue green taco).sample,
  name: Faker::RickAndMorty.character, sex: %w(M F).sample,
  description: Faker::RickAndMorty.quote)
c2 = Cat.create(birth_date: Faker::Date.between(20.years.ago, Date.today),
  color: %w(orange blue green taco).sample,
  name: Faker::RickAndMorty.character, sex: %w(M F).sample,
  description: Faker::RickAndMorty.quote)
Cat.create(birth_date: Faker::Date.between(20.years.ago, Date.today),
  color: %w(orange blue green taco).sample,
  name: Faker::RickAndMorty.character, sex: %w(M F).sample,
  description: Faker::RickAndMorty.quote)
Cat.create(birth_date: Faker::Date.between(20.years.ago, Date.today),
  color: %w(orange blue green taco).sample,
  name: Faker::RickAndMorty.character, sex: %w(M F).sample,
  description: Faker::RickAndMorty.quote)
Cat.create(birth_date: Faker::Date.between(20.years.ago, Date.today),
  color: %w(orange blue green taco).sample,
  name: Faker::RickAndMorty.character, sex: %w(M F).sample,
  description: Faker::RickAndMorty.quote)


  #  id         :integer          not null, primary key
  #  cat_id     :integer          not null
  #  start_date :date             not null
  #  end_date   :date             not null
  #  status     :string           default("PENDING"), not null
  #  created_at :datetime         not null
  #  updated_at :datetime         not null

CatRentalRequest.create(cat_id: c1.id, start_date: Time.now, end_date: 10.days.from_now, status: 'APPROVED')
CatRentalRequest.create(cat_id: c2.id, start_date: Time.now, end_date: 10.days.from_now, status: 'PENDING')
