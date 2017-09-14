json.array! @parties do |party|
  json.name party.name
  json.location party.location
  json.guest do
    json.array! party.guests do |guest|
      json.name guest.name
      json.age guest.age
      json.favorite_color guest.favorite_color
    end
  end

end
