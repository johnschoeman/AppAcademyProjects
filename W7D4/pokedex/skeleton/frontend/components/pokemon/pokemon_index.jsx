import React from 'react';
import PokemonIndexItem from './pokemon_index_item';
import PokemonDetailContainer from '../pokemon_detail/pokeman_detail_container';
import {Route} from 'react-router-dom';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);

  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    let pokemon = this.props.pokemon;
    return (
      <div className="index">
        poke index
        <ul>
          {pokemon.map((poke,idx) => {
            return <PokemonIndexItem poke={poke} key={`poke-index-item-${idx}`} />;
          })}
        </ul>
      </div>
    );
  }
}

export default PokemonIndex;
