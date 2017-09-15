import { connect } from 'react-redux';
import { requestNewPokemon } from '../../actions/pokemon_actions';
import PokemonForm from './pokemon_form';

const mapStateToProps = ({errors}) => ({
  errors: errors
});

const mapDispatchToProps = (dispatch) => ({
  createPokemon: (data) => dispatch(requestNewPokemon(data))
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonForm);
