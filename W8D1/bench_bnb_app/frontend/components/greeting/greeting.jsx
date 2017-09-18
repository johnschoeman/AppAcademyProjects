import React from 'react';
import { Link } from 'react-router-dom';

class Greeting extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let user = this.props.currentUser;
    let greeting = undefined;

    if (user) {
      greeting = (<div>
                    <h1>Welcome {user.username}</h1>
                    <button onClick={this.props.logout}>Log Out</button>
                  </div>);
    } else {
      greeting = (<div>
                    <Link to="/signup">Sign Up</Link>
                    <Link to="/login">Log In</Link>
                  </div>);
    }

    return (
      <div>
        { greeting }
      </div>
    );
  }
}

export default Greeting;
