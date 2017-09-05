const Util = {
  inherits (ChildClass, ParentClass) {
    ChildClass.prototype = Object.create(ParentClass.prototype);
    ChildClass.prototype.constructor = ChildClass;
  },

  // Return a randomly oriented vector with the given length.
  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  // Scale the length of a vector by the given amount.
  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  },

  dist (obj1, obj2) {
    return Math.sqrt(Math.pow((obj1.pos[0] - obj2.pos[0]), 2) +
      Math.pow((obj1.pos[1] - obj2.pos[1]), 2));
  }
};

module.exports = Util;
