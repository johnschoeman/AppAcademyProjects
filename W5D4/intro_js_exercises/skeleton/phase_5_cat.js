function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return `${this.owner} loves ${this.name}`;
};
Cat.prototype.meow = function() {
  return 'meow';
};
const fluffy = new Cat('fluffy', 'Rachel');
const potatoe = new Cat('potatoe', 'John');

// console.log(fluffy.cuteStatement());
// console.log(potatoe.cuteStatement());

fluffy.meow = function() {
  return 'rawr';
};

// console.log(fluffy.meow());
// console.log(potatoe.meow());
