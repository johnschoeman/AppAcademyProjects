import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import * as APIUtil from './util/session_api_util';

window.login = APIUtil.login;
window.logout = APIUtil.logout;
window.signup = APIUtil.signup;

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  const store = configureStore();

  window.getState = store.getState;
  window.dispatch = store.dispatch;

  ReactDOM.render(<h1>Welcome to BenchBnB</h1>, root);
});
