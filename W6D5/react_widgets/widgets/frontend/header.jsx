import React from 'react';
import ReactDOM from 'react-dom';

export default class Header extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let panes = this.props.panes;

    return (
      <ul>
          {panes.map(function(pane) {
              return (<h1>{pane.title}</h1>);
            })
          }
      </ul>
    );
  }
}
