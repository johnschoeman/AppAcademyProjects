import { connect } from 'react-redux';
import React from 'react';
import ItemDetail from './item_detail';
import { selectPokemonItem } from '../../reducers/selectors';

const mapStateToProps = (state, {match}) => ({
  item: selectPokemonItem(state, match.params.itemId)
}
);

export default connect(mapStateToProps)(ItemDetail);
