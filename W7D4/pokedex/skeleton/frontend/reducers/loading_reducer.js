import * as Action from '../actions/pokemon_actions';
import { merge } from 'lodash';

const loadingReducer = (state=false, action) => {
  switch (action.type) {
    case Action.LOADING_ALL_POKEMON:
        return true;
    case Action.LOADING_ONE_POKEMON:
      return true;
    case Action.RECEIVE_ALL_POKEMON:
      return false;
    case Action.RECEIVE_ONE_POKEMON:
      return false;
    case Action.RECEIVE_NEW_POKEMON:
      return false;
    case Action.RECEIVE_POKEMON_ERROR:
      return false;
    default:
      return state;
  }
};

export default loadingReducer;
