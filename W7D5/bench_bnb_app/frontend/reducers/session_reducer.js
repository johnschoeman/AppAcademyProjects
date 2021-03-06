import { RECEIVE_CURRENT_USER } from '../actions/session_actions';

const defaultState = { currentUser: null };

const sessionReducer = (state = defaultState, action) => {
  Object.freeze(state);

  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      let newState = { currentUser: action.user };
      return newState;
    default:
      return state;
  }
};

export default sessionReducer;
