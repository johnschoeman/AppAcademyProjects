import { values } from 'lodash';

export const selectAllPokemon = (state) => {
  return values(state.entities.pokemon);
};

export const selectOnePokemon = (state) => {
  let currPokeId = state.ui.pokeDisplay;
  return state.entities.pokemon[currPokeId];
};
