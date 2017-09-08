/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);


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


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor (HTMLElements) {
    this.HTMLElements = HTMLElements;
  }

  html(string = null) {
    if (string) {
      this.HTMLElements.forEach( (el) => {
        el.innerHTML = string;
      });
    } else {
       return this.HTMLElements[0].innerHTML;
    }
  }

  empty() {
    this.HTMLElements.forEach( (el) => {
      el.innerHTML = "";
    });
  }

  append(arg) {
    console.log(arg.outerHTML);
    this.HTMLElements.forEach( (el) => {
      if (typeof arg === 'string') {
        el.innerHTML += arg;
      } else {
        el.innerHTML += arg.outerHTML;
      }
    });
  }

  attr(name, value = null) {
    let res = [];
    this.HTMLElements.forEach( (el) => {
      if (!value) {
        res.push(el.getAttribute(name));
      } else {
        el.setAttribute(name, value);
      }
    });
    return res[0];
  }

  addClass(name) {
    this.HTMLElements.forEach( (el) => {
      el.className = name;
    });
  }

  removeClass() {
    this.HTMLElements.forEach( (el) => {
      el.removeAttribute('class');
    });
  }

  children() {
    let result = [];
    this.HTMLElements.forEach( (el) => {
      result = result.concat(el.children);
    });
    return new DOMNodeCollection(result);
  }

  parent() {
    let result = [];
    this.HTMLElements.forEach( (el) => {
      result.push(el.parentElement);
    });
    return new DOMNodeCollection(result);
  }

  find(arg) {
    let result = [];
    this.HTMLElements.forEach( (el) => {
      console.log(el.querySelectorAll(arg));
      let arr = Array.from(el.querySelectorAll(arg));
      result = result.concat(arr);
    });
    return new DOMNodeCollection(result);
  }

  remove() {
    this.HTMLElements.forEach( (el) => {
      el.remove(el);
    });
    this.HTMLElements = [];
  }

  on(type, callback) {
    this.HTMLElements.forEach( (el) => {
      el.addEventListener(type, callback);
      if (!el.eventCallBacks) {
        el.eventCallBacks = [];
      }
      el.eventCallBacks.push(callback);
    });
  }

  off(type) {
    this.HTMLElements.forEach( (el) => {
      el.eventCallBacks.forEach( (cb) => {
        el.removeEventListener(type, cb);
      });
    });
  }


}


module.exports = DOMNodeCollection;


/***/ })
/******/ ]);