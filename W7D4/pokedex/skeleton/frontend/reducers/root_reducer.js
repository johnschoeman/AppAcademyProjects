import { combineReducers } from 'redux';
import entitiesReducer from './entities_reducer';
import uiReducer from './ui_reducer';
import errorsReducer from './errors_reducer';
import loadingReducer from './loading_reducer';


const rootReducer = combineReducers({
  entities: entitiesReducer,
  ui: uiReducer,
  errors: errorsReducer,
  loading: loadingReducer
});

export default rootReducer;
