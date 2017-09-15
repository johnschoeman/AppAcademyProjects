import * as Util from '../util/api_util';

export const RECEIVE_ALL_POKEMON = 'RECEIVE_ALL_POKEMON';
export const RECEIVE_ONE_POKEMON = 'RECEIVE_ONE_POKEMON';
export const RECEIVE_NEW_POKEMON = 'RECEIVE_NEW_POKEMON';
export const RECEIVE_POKEMON_ERROR = 'RECEIVE_POKEMON_ERROR';
export const LOADING_ALL_POKEMON = 'LOADING_ALL_POKEMON';
export const LOADING_ONE_POKEMON = 'LOADING_ONE_POKEMON';

export const receiveAllPokemon = pokemon => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receiveOnePokemon = poke => ({
  type: RECEIVE_ONE_POKEMON,
  poke
});

export const receiveNewPokemon = ({pokemon}) => ({
  type: RECEIVE_NEW_POKEMON,
  pokemon
});

export const receivePokemonErrors = (errors) => ({
  type: RECEIVE_POKEMON_ERROR,
  errors
});

export const loadingOnePokemon = () => ({
  type: LOADING_ONE_POKEMON
});

export const loadingAllPokemon = () => ({
  type: LOADING_ALL_POKEMON
});


export const requestAllPokemon = () => (dispatch) => {
  dispatch(loadingAllPokemon());
  return Util.fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
};

export const requestOnePokemon = (pokeId) => (dispatch) => {
  dispatch(loadingOnePokemon());
  return Util.fetchOnePokemon(pokeId)
  .then(poke => dispatch(receiveOnePokemon(poke)));
};

export const requestNewPokemon = (data) => (dispatch) => {
  dispatch(loadingOnePokemon());
  return Util.createOnePokemon(data)
    .then(
      poke => {
        dispatch(receiveNewPokemon(poke));
        return poke;
      },
      errors => {
        console.log(errors);
        dispatch(receivePokemonErrors(errors.responseJSON));
      }
  );
};
