# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all

u1 = User.create(username: Faker::RickAndMorty.character)
u2 = User.create(username: Faker::RickAndMorty.character)
u3 = User.create(username: Faker::RickAndMorty.character)
u4 = User.create(username: Faker::RickAndMorty.character)
u5 = User.create(username: Faker::RickAndMorty.character)

#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null

a1 = Artwork.create(title: Faker::RickAndMorty.quote, image_url: Faker::Internet.url, artist_id: u1.id)
a2 = Artwork.create(title: Faker::RickAndMorty.quote, image_url: Faker::Internet.url, artist_id: u1.id)
a3 = Artwork.create(title: Faker::RickAndMorty.quote, image_url: Faker::Internet.url, artist_id: u2.id)
a4 = Artwork.create(title: Faker::RickAndMorty.quote, image_url: Faker::Internet.url, artist_id: u3.id)
a5 = Artwork.create(title: Faker::RickAndMorty.quote, image_url: Faker::Internet.url, artist_id: u4.id)
a6 = Artwork.create(title: Faker::RickAndMorty.quote, image_url: Faker::Internet.url, artist_id: u4.id)
a7 = Artwork.create(title: Faker::RickAndMorty.quote, image_url: Faker::Internet.url, artist_id: u4.id)


# Table name: artwork_shares
#
#  id         :integer          not null, primary key
#  artwork_id :integer          not null
#  viewer_id  :integer          not null

as1 = ArtworkShare.create(artwork_id: a1.id, viewer_id: u2.id)
as2 = ArtworkShare.create(artwork_id: a1.id, viewer_id: u3.id)
as3 = ArtworkShare.create(artwork_id: a1.id, viewer_id: u4.id)
as4 = ArtworkShare.create(artwork_id: a2.id, viewer_id: u2.id)
as5 = ArtworkShare.create(artwork_id: a3.id, viewer_id: u4.id)
as6 = ArtworkShare.create(artwork_id: a4.id, viewer_id: u3.id)
