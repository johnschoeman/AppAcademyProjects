import React from 'react';
import ReactDOM from 'react-dom';


class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currTime: new Date()
    };
  }

  componentDidMount() {
    setInterval(this.tick.bind(this),1000);
  }

  tick() {
    this.setState({
        currTime: new Date()
    });
  }

  render() {
    const date = this.state.currTime;

    return (
      <div className="header long">
        <h1>Clock</h1>
        <div className="clock component">
          <div className = "time content">
            <p>Time: </p>
            <p>{date.toLocaleTimeString()}</p>
          </div>
          <div className="date content">
            <p>Date: </p>
            <p>{`${date.toLocaleDateString()}`}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default Clock;
