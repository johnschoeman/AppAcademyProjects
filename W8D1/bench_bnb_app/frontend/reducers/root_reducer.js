import { combineReducers } from 'redux';
import errorsReducer from './errors_reducer';
import sessionReducer from './session_reducer';
import entitiesReducer from './entities_reducer';


// Sample State
//
// {
//   entities: {
//     benches: {
//       1: {
//         id: 1,
//         description: "benchy the bench",
//         lat: -122,
//         lng: 32
//       }
//
//     }
//   },
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
  entities: entitiesReducer,
  session: sessionReducer,
  errors: errorsReducer
});

export default RootReducer;
