import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

import * as Actions from './actions/session_actions';

window.login = Actions.login;
window.logout = Actions.logout;
window.signup = Actions.signup;

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  const store = configureStore();

  // Testing Start
  window.getState = store.getState;
  window.dispatch = store.dispatch;
  // Testing End

  ReactDOM.render(<Root store={ store } />, root);
});
