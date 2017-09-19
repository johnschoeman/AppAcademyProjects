import { connect } from 'react-redux';
import Search from './search';
import { fetchBenches } from '../actions/bench_actions';

const mapStateToProps = (state, ownProps) => {
  let benches = Object.values(state.entities.benches);
  return {
    benches
  };
};

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    fetchBenches: () => dispatch(fetchBenches())
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Search);
