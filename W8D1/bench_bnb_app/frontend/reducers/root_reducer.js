import { combineReducers } from 'redux';
import errorsReducer from './errors_reducer';
import sessionReducer from './session_reducer';


// Sample State
//
// {
//   session: {
//     currentUser: {
//       id: 1,
//       username: 'breakfast'
//     }
//   },
//   errors: {
//     session: []
//   }
// }

const RootReducer = combineReducers({
  session: sessionReducer,
  errors: errorsReducer
});

export default RootReducer;
