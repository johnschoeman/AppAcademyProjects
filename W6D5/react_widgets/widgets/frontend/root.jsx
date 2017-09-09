import React from 'react';

import Clock from './clock';
import Weather from './weather';
import AutoComplete from './autocomplete';
const Root = (names) => {
  return (

    <div>
      <Clock />
      <Weather />
      <AutoComplete names = {names} />
    </div>
  );
};


export default Root;
