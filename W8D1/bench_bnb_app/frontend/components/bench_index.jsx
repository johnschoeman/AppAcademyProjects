import React from 'react';
import BenchIndexItem from './bench_index_item';

class BenchIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchBenches();
  }

  render() {
    return (
      <div>
        <h3>bench index</h3>
        <ul>
          {this.props.benches.map((bench, idx) => {
            return (<li key={`bench-${idx}`}><BenchIndexItem bench={bench}/></li>);
          })}
        </ul>
      </div>
    );
  }
}

export default BenchIndex;
