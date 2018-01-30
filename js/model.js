function assert(condition, message) {
    if (!condition) {
        throw message || "Assertion failed";
    }
}

var Model = function (x) {
  this.__value = x;
};

Model.of = function (x) { return new Model(x); };


var person = {
    firstName: 'Jimmy',
    lastName: 'Smith',
    get fullName() {
        return this.firstName + ' ' + this.lastName;
    },
    set fullName (name) {
        var words = name.toString().split(' ');
        this.firstName = words[0] || '';
        this.lastName = words[1] || '';
    }
};


// can i leverage the pattern below to fire an event when *any* property is set?
var _Model = {
    var: null,
    get prop() {
        return this.__prop.toUpperCase();
    },
    set prop (name) {
        this.__prop = name;
    }
};

var _n = Object.create(_Model);

// just for fun, can I create a function that returns an object that fires an event for each setter
function creator(obj) {
  var prop,
    result = Object.create({}),
    properties = {};
  Object.keys(obj).forEach(function (prop) {
      Object.defineProperty(result, prop, {
        set: function(val) {
          console.log('setting value: ', val);
          properties['__' + prop] = val;
        },
        get: function() {
          return properties['__' + prop];
        }
      });
      result[prop] = obj[prop];
  });
  return result;
}

d = creator({a:1});

