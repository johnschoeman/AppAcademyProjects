json.pokemon do
  json.extract! @pokemon, :id, :name, :attack, :defense
  if asset_path(@pokemon.image_url)
    json.image_url asset_path(@pokemon.image_url)
  end
  json.moves @pokemon.moves
  json.poke_type @pokemon.poke_type
end

json.items do
  json.array! @pokemon.items do |item|
    json.extract! item, :id, :name, :pokemon_id, :price, :happiness
    json.image_url asset_path(item.image_url)
  end
end
