import React from 'react';
import {Provider} from 'react-redux';
import PokemonIndexContainer from './pokemon/pokemon_index_container';
import { HashRouter, Route, Switch } from 'react-router-dom';
import PokemonDetailContainer from './pokemon_detail/pokeman_detail_container';
import PokemonFormContainer from './pokemon_form/pokemon_form_container';

const Root = ({ store }) => (
  <Provider store={store}>
    <HashRouter>
      <div className="app">
        <Route path="/" component={PokemonIndexContainer} />
        <Switch>
          <Route path="/pokemon/:pokemonId" component={PokemonDetailContainer} />
          <Route component={PokemonFormContainer}/>
        </Switch>

      </div>
    </HashRouter>
  </Provider>
);

export default Root;
