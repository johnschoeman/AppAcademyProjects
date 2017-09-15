import { values } from 'lodash';

export const selectAllPokemon = (state) => {
  return values(state.entities.pokemon);
};

export const selectOnePokemon = (state) => {
  let currPokeId = state.ui.pokeDisplay;
  return state.entities.pokemon[currPokeId];
};

export const selectPokemonItem = (state, itemId) => {
  let items = state.entities.items;
  let itemArr = Object.keys(items).map((k) => items[k] );
  let item = itemArr.filter((obj) => { return obj.id == itemId; } );
  return item[0];
};
