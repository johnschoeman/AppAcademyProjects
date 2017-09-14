import React from 'react';
import PokemonIndexItem from './pokemon_index_item';

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
      <div>
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
