import { connect } from 'react-redux';
import { requestOnePokemon } from '../../actions/pokemon_actions';
import { selectOnePokemon } from '../../reducers/selectors';
import PokemonDetail from './pokemon_detail';


const mapStateToProps = (state) => ({
  poke: selectOnePokemon(state),
  items: state.entities.items
});

const mapDispatchToProps = (dispatch) => ({
  requestOnePokemon: (pokeId) => (
    dispatch(requestOnePokemon(pokeId))
  )
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonDetail);
