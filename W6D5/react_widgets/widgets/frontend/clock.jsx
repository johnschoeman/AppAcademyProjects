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
      <div className="clock">
        <div className = "time">
          <p>Time: </p>
          <p>{`${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`}</p>
        </div>
        <div className="date">
          <p>Date: </p>
          <p>{`${date.getDate()}`}</p>
        </div>
      </div>
    );
  }
}

export default Clock;
