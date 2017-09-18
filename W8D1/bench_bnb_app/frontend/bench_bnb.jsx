import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

import * as Actions from './actions/bench_actions';
import * as BenchApi from './util/bench_api_util';

// Testing Start
window.fetchBenches = Actions.fetchBenches;

window.getBenches = BenchApi.getBenches;
window.postBench = BenchApi.postBench;
// Testing End

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  let store = undefined;

  if (window.currentUser) {
    const preLoadedState = { session: {currentUser: window.currentUser } };
    store = configureStore(preLoadedState);
  } else {
    store = configureStore();
  }

  // Testing Start
  window.getState = store.getState;
  window.dispatch = store.dispatch;
  // Testing End

  ReactDOM.render(<Root store={ store } />, root);
});
