import { RECEIVE_ALL_POKEMON, RECEIVE_ONE_POKEMON } from '../actions/pokemon_actions';
import { merge } from 'lodash';

const itemReducer = (state={}, action) => {
  Object.freeze(state);

  switch (action.type) {
    case RECEIVE_ONE_POKEMON:
      let newState = {};
      merge(newState, action.poke.items);
      return newState;
    default:
      return state;
  }
};

export default itemReducer;
