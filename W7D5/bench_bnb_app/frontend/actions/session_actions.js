import * as APIUtil from '../util/session_api_util';

export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER';
export const RECEIVE_SESSION_ERRORS = 'RECEIVE_SESSION_ERRORS';

export const receiveCurrentUser = (user) => ({
  type: RECEIVE_CURRENT_USER,
  user
});

export const receiveSessionErrors = (errors) => ({
  type:  RECEIVE_SESSION_ERRORS,
  errors
});

export const login = (user) => (dispatch) => {
  return APIUtil.login(user)
  .then(res => { dispatch(receiveCurrentUser(res)); },
        error => { dispatch(receiveSessionErrors(error)); } );
};

export const logout = () => (dispatch) => {
  return APIUtil.logout()
  .then(res => {dispatch(receiveCurrentUser(null));},
        error => { dispatch(receiveSessionErrors(error));});
};

export const signup = (user) => (dispatch) => {
  return APIUtil.signup(user)
  .then(res => {dispatch(receiveCurrentUser(res));},
        error => { dispatch(receiveSessionErrors(error));});
};
