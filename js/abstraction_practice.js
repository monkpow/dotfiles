var Bright = {};

(function (ns) {
  var likesCheese = true;

  function hasADog() {
    console.log('eats cheese');
  }

  function eatsACat() {
    console.log('freaque sleaves');
  }

  ns.SubConstructor = function () {
    return {
      doesSomething : function doesSomething () {
        hasADog();
        eatsACat();
        console.log(likesCheese);
      }
    };
  };
})(Bright);

console.log(new Bright.SubConstructor().doesSomething());

//I'm curious if I extend subConstructor, can I over-riede hasADog


(function (ns) {
  var ptype = ns.SubConstructor;

  function hasADog() {
    console.log('overriden');
  }

  ns.ExtendedConstructor = function () {
    var prototype = new ptype();
    prototype.imagination = 'dead';
    return prototype;
  };
})(Bright);

console.log(new Bright.ExtendedConstructor().doesSomething());
