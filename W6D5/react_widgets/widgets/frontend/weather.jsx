
import React from 'react';
import ReactDOM from 'react-dom';


class Weather extends React.Component{
  constructor(prop) {
    super(prop);
    this.state = {
      weather: null,
      currentCity: null
    };
    this.getWeather = this.getWeather.bind(this);
  }

  componentDidMount() {
    let that = this;

    navigator.geolocation.getCurrentPosition(function(pos) {
      that.getWeather(pos);
    });
  }

  getWeather(pos) {
    let lat = pos.coords.latitude;
    let long = pos.coords.longitude;
    let url = `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&APPID=cc9a7035f5df20c3927a8e77ab182346`;
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = () => {
        if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
           if (xmlhttp.status == 200) {
               this.setState({weather: JSON.parse(xmlhttp.responseText)});
           }
           else if (xmlhttp.status == 400) {
              alert('There was an error 400');
           }
           else {
               alert('something else other than 200 was returned');
           }
        }
  };

  xmlhttp.onload = function () {

  }

  xmlhttp.open("GET", url, true);
  xmlhttp.send();

  }

  // arr.map((item, idx) => <li key={idx}>{JSON.stringify(item)}</li>)
  render(){
    let content = <div></div>;

    if (this.state.weather) {
      let weather = this.state.weather;
      let temp = (weather.main.temp - 273.15) * 1.8 + 32;
      content = <div>
                  <p>{weather.name}</p>
                  <p>{temp.toFixed(1)} degrees</p>
                </div>;
    } else {
      content = <div className='loading'>loading weather...</div>;
    }
    return (
      <div>
        <h1>Weather</h1>
        <div className='weather'>
          {content}
        </div>
      </div>
    );
  }

}







export default Weather;
