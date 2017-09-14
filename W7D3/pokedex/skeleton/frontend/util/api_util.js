export const fetchAllPokemon = () => {
  return $.ajax({
    method: 'GET',
    url: 'api/pokemon'
  });
};

export const fetchOnePokemon = (pokeId) => {
  return $.ajax({
    method: 'GET',
    url: `api/pokemon/${pokeId}`
  });
};
