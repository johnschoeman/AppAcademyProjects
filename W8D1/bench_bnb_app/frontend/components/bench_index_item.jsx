import React from 'react';

export default (props) => {
  let bench = props.bench;
  return (<div>
    {`bench: ${bench.description} - `}
    <br/>
    {`lat: ${bench.lat} - `}
    <br/>
    {`lng: ${bench.lng} `}
  </div>);
};
