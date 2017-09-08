const DOMNodeCollection = require('./dom_node_collection.js');


var functionQueue = [];

var docReadyBool = false;

function readyCB () {
  docReadyBool = true;
  functionQueue.forEach(function (cb) {
    cb();
  });
}

window.$l = function $l(arg) {
  console.log(docReadyBool);
  if (!document.hasReadyListener) {
    document.addEventListener('DOMContentLoaded', readyCB, false);
    document.hasReadyListener = true;
  }

  if (typeof arg === 'string') {
    let nodeList = document.querySelectorAll(arg);
    nodeList = Array.from(nodeList);
    return new DOMNodeCollection(nodeList);
  }

  if (arg instanceof HTMLElement) {
    let argArr = [arg];
    return new DOMNodeCollection(argArr);
  }

  if (arg instanceof Function) {
    if (docReadyBool) {
      arg();
    } else {
      functionQueue.push(arg);
    }
  }


};

window.$l.extend = function (...objects) {
  let result = {};
  objects.forEach( (obj) => {
    Object.keys(obj).forEach( (key) => {
      result[key] = obj[key];
    });
  });
  return result;
};

window.$l.ajax = function (options) {
  let defaults = {
    success: (res) => {
      console.log('success');
      console.log(res);
     },
    error: (res) => {
      console.log('error');
      console.log(res);
     },
    url: "",
    method: "GET",
    data: "",
    contentTYPE: "JSON"
  };

  options = window.$l.extend(defaults, options);

  const xhr = new XMLHttpRequest();

  xhr.open(options['method'], options['url']);

  xhr.onload = function () {
    console.log(xhr.status);
    console.log(xhr.responseType);
    console.log(xhr.response);
    let res = JSON.parse(xhr.response);
    if (xhr.status === 200) {
      options['success'](res);
    } else {
      options['error'](res);
    }
  };

  const optionalData = options['data'];
  xhr.send(optionalData);
};

// $.ajax({
//   type: 'GET',
//   url: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=bcb83c4b54aee8418983c2aff3073b3b",
//   success(data) {
//     console.log("We have your weather!")
//     console.log(data);
//   },
//   error() {
//     console.error("An error occurred.");
//   },
// });
