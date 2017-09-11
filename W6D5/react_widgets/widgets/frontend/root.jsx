import React from 'react';

import Clock from './clock';
import Weather from './weather';
import AutoComplete from './autocomplete';
import Tabs from './tabs';

let nameList = ["John","Jesse","David"];
let paneList = [{title: "tab1", content: "Content A"},
               {title: "tab2", content: "Content B"},
               {title: "tab3", content: "Content C"}];

const Root = () => {
  return (

    <div>
      <Clock />
      <Weather />
      <AutoComplete names = {nameList} />
      <Tabs panes = {paneList} />
    </div>
  );
};


export default Root;
