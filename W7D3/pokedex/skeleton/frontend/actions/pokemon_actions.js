import * as Util from '../util/api_util';

export const RECEIVE_ALL_POKEMON = 'RECEIVE_ALL_POKEMON';
export const RECEIVE_ONE_POKEMON = 'RECEIVE_ONE_POKEMON';
// export const RECEIVE_POKE_DISPLAY = 'RECEIVE_POKE_DISPLAY';

export const receiveAllPokemon = pokemon => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receiveOnePokemon = poke => ({
  type: RECEIVE_ONE_POKEMON,
  poke
});

// export const receivePokeDisplay = pokeId => ({
//   type: RECEIVE_POKE_DISPLAY,
//   pokeId
// });



export const requestAllPokemon = () => (dispatch) => {
    return Util.fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
};


export const requestOnePokemon = (pokeId) => (dispatch) => {
  return Util.fetchOnePokemon(pokeId)
  .then(poke => dispatch(receiveOnePokemon(poke)));
};
