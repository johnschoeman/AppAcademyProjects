import React from 'react';
import {withRouter} from 'react-router-dom';


class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "",
      image_url: "/assets/pokemon_snaps/1-746592ddbf88f824b4897ee29c2e9018b6a88098e45136531eb45f46bb6f2e4e.svg",
      poke_type: "fire",
      attack: 0,
      defense: 0,
      moves: []
    };

    this.updateState = this.updateState.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  updateState(e) {
    e.preventDefault();
    let key = e.currentTarget.id;
    let val = e.currentTarget.value;
    let oldMoves = this.state.moves;
    if (key === 'move1') {
      let newMoves = oldMoves;
      newMoves[0] = val;
      this.setState({moves: newMoves});
    } else if (key === 'move2') {
      let newMoves = oldMoves;
      newMoves[1] = val;
      this.setState({moves: newMoves});
    } else {
      this.setState({[key]: val});
    }
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createPokemon({pokemon: this.state}).then(({pokemon}) => {
      this.props.history.push(`pokemon/${pokemon.id}`);
    });
  }




  render() {
    console.log(this.props);
    let errors = this.props.errors;
    console.log(errors);
    return (
      <div>
        <div className="errors">{errors.join(" - ")}</div>
        <form>
          <input type="text"
                 id='name'
                 onChange={this.updateState}
                 value={this.state.name}
                 placeholder="Name">
          </input><br/>
          <input type="text"
                 id='image_url'
                 onChange={this.updateState}
                 value={this.state.image_url}
                 placeholder="Image_Url">
          </input><br/>
          <input type="number"
                 id='attack'
                 onChange={this.updateState}
                 value={this.state.attack}
                 placeholder="Attack">
          </input><br/>
          <input type="number"
                 id='defense'
                 onChange={this.updateState}
                 value={this.state.defense}
                 placeholder="Defense">
          </input><br/>
          <select
                 id='poke_type'
                 onChange={this.updateState}>
            <option value="fire">Fire</option>
            <option value="water">Water</option>
          </select><br/>
          <input type="text"
                 id='move1'
                 onChange={this.updateState}
                 value={this.state.moves[0]}
                 placeholder="Move1">
          </input><br/>
          <input type="text"
                 id='move2'
                 onChange={this.updateState}
                 value={this.state.moves[1]}
                 placeholder="Move2">
          </input><br/>

          <button type="submit" onClick={this.handleSubmit}>Submit</button>
        </form>
      </div>
    );
  }
}

export default withRouter(PokemonForm);
