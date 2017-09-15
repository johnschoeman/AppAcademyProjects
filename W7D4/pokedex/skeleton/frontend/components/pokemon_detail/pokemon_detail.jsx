import React from 'react';
import ItemDetailContainer from '../item_detail/item_detail_container';
import { Link, Route } from 'react-router-dom';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    console.log('---Did Mount---');
    let pokemonId = this.props.match.params.pokemonId;
    this.props.requestOnePokemon(pokemonId);
  }

  componentWillReceiveProps(newProps) {
    console.log('---Will Receive Props---');
    let pokemonId = newProps.match.params.pokemonId;
    if (parseInt(pokemonId) !== parseInt(this.props.uiPokeDisplay)) {
      this.props.requestOnePokemon(pokemonId);
    }
  }

  render() {
    let poke = this.props.poke;
    let items = this.props.items;
    console.log('loading', this.props.loading);

    if (poke && items && !this.props.loading) {
      let arrItems = Object.keys(items).map((key) => items[key]);
      return (
        <div className="detail-container">
          <ul className="pokemon-info">
            <li><img className="detail-img" src={poke.image_url}></img></li>
            <li>{poke.id}</li>
            <li>{poke.name}</li>
          </ul>
          <ul className="item-list">
            {arrItems.map( (item) => {
              return (
                <li>
                  <Link to={`/pokemon/${poke.id}/item/${item.id}`}>
                    <img src={item.image_url}></img>
                  </Link>
                </li>
                );
            })}
          </ul>
          <Route path="/pokemon/:pokemonId/item/:itemId" component={ItemDetailContainer} />
        </div>
      );
  } else {
    return (
      <div id="loading-pokeball-container">
        <div id="loading-pokeball"></div>
      </div>
    );
  }
}
}

export default PokemonDetail;
