import { RECEIVE_POKEMON_ERROR } from '../actions/pokemon_actions';
import { merge } from 'lodash';


const errorsReducer = (state = [], action) => {
  Object.freeze(state);
  let newState = [];
  switch (action.type) {
    case RECEIVE_POKEMON_ERROR:
      newState = newState.concat(action.errors);
      return newState;
    default:
      return newState;
  }
};

export default errorsReducer;
