import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
import {HashRouter, Route} from 'react-router-dom';

import { fetchOnePokemon, createOnePokemon } from './util/api_util';
import { receiveOnePokemon, requestOnePokemon, requestNewPokemon } from './actions/pokemon_actions';


window.fetchOnePokemon = fetchOnePokemon;
window.receiveOnePokemon = receiveOnePokemon;
window.requestOnePokemon = requestOnePokemon;
window.createOnePokemon = createOnePokemon;
window.requestNewPokemon = requestNewPokemon;

document.addEventListener("DOMContentLoaded", () => {
  const store = configureStore();
  const rootEl = document.getElementById('root');
  window.dispatch = store.dispatch;
  window.getState = store.getState;
  ReactDOM.render(<Root store={store}/>, rootEl);
});
