import React from 'react';
import {Link} from 'react-router-dom';

class PokemonIndexItem extends React.Component{
  constructor(props){
    super(props);
  }

  render() {
    let poke = this.props.poke;
    return (
      <Link to={`/pokemon/${poke.id}`}>
        <li>{poke.name} <img src={poke.image_url}></img></li>
      </Link>
    );
  }
}


export default PokemonIndexItem;
