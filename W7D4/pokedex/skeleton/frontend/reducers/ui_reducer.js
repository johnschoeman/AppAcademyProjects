import { merge } from 'lodash';
import { RECEIVE_ONE_POKEMON } from '../actions/pokemon_actions';

const uiReducer = (state = {}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_ONE_POKEMON:
      let newState = {};
      let pokeDisplay = action.poke.pokemon.id;
      merge(newState, {pokeDisplay});
      return newState;
    default:
      return state;
  }
};


export default uiReducer;
