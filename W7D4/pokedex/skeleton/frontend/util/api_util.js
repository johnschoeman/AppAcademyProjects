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

export const createOnePokemon = (data) => {
  return $.ajax({
    method:'POST',
    url:`api/pokemon`,
    data: data
  });
};
