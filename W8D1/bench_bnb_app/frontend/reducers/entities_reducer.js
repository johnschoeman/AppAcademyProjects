import { combineReducers } from 'redux';
import { benchesReducer } from './benches_reducer';

const entitiesReducer = combineReducers({
  benches: benchesReducer
  }
);

export default entitiesReducer;
