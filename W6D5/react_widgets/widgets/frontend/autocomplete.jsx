import React from 'react';
import ReactDOM from 'react-dom';

class AutoComplete extends React.Component {
  constructor(prop) {
    super(prop);
    this.prop = prop;
    this.state = {
      inputVal: ""
    };
    this.setInputVal = this.setInputVal.bind(this);
    this.fillInput = this.fillInput.bind(this);
  }

  setInputVal(event){
    event.preventDefault();
    let val = event.currentTarget.value;
    this.setState({inputVal: val});
  }

  filterNames(){

    let that = this;
    let results = [];
    let names = this.prop.names;

    for (let i = 0; i < names.length; i++){
      if (names[i].startsWith(this.state.inputVal)){
        results.push(names[i]);
      }

    }
    return results;
  }

  fillInput(event) {
    event.preventDefault();
    let val = event.currentTarget.innerHTML;
    console.log(val);
    this.setState({inputVal: val});
  }

  render(){
    let names = this.filterNames();

    let content = <div className="header short">
      <h1>AutoComplete</h1>
      <div className="autocomplete component">
        <div className="">
          <input type="text"
            onChange={this.setInputVal}
            value={this.state.inputVal}>
          </input>
          <ul>
            {names.map((name) => {
              return <li onClick={ this.fillInput }>{name}</li>;
            })}
          </ul>
        </div>
      </div>
    </div>;
    return content;
  }

}


export default AutoComplete;
