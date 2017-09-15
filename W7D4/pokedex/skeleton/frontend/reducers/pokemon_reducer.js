import { RECEIVE_ALL_POKEMON, RECEIVE_ONE_POKEMON, RECEIVE_NEW_POKEMON } from '../actions/pokemon_actions';
import { merge } from 'lodash';

const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);
  let newState = {};
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      merge(newState, action.pokemon);
      return newState;
    case RECEIVE_ONE_POKEMON:
      return state;
    case RECEIVE_NEW_POKEMON:
      merge(newState, state);
      newState[action.pokemon.id] = action.pokemon;
      return newState;
    default:
      return state;
  }
};


export default pokemonReducer;
