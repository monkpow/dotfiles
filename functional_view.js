var _ = require('underscore');

var View = function (x) {
  this.__value = x;
};

View.of = function (x) { return new View(x); };

// (a -> b) -> Container a -> Container b
View.prototype.map = function (f) {
  var val = this.__value,
  result = [];

  if (!(val instanceof Array)) {
    val = [val];
  }

  val.forEach(function (value) {
    result.push(View.of(f(value)));
  });

  return result;
};

View.prototype.render = function (f) {
  console.log(this.map(f));
};

var SpecializedView = Object.create(View);

var data = {
  a: 1,
  b: 2,
  c: 'string'
};

function text(data) {
  return (data);
}

html_view = _.template('<h1><%= a %></h1>');

console.log(View.of(data).map(html_view));
// SpecializedView.of(data).render(text);
// SpecializedView.of([data]).render(html_view);

// HACK WEEK IDEA:  Backbone in a functional style which renders the segment document
// Can render using map
// Can model data using ECMA5 ObjectsA
// Use recursion instead of loops
// Can attach events to Views?
// Should bind data to Views(?)
// Should pass test suite for Backbone?
// Should pass test suite for Cadence?
