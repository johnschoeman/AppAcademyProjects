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
