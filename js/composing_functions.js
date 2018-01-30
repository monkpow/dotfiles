var _ = require('underscore');

var CARS = [
    {name: "Ferrari FF", horsepower: 660, dollar_value: 700000, in_stock: true},
    {name: "Spyker C12 Zagato", horsepower: 650, dollar_value: 648000, in_stock: false},
    {name: "Jaguar XKR-S", horsepower: 550, dollar_value: 132000, in_stock: false},
    {name: "Audi R8", horsepower: 525, dollar_value: 114200, in_stock: false},
    {name: "Aston Martin One-77", horsepower: 750, dollar_value: 1850000, in_stock: true},
    {name: "Pagani Huayra", horsepower: 700, dollar_value: 1300000, in_stock: false},
  ];



// Exercise 1:
// ============
// use _.compose() to rewrite the function below. Hint: _.prop() is curried.
// write a curried _.prop() function

function property (property, x) { return function(x) { return x[property]; }; }
function last(xs) { return xs[xs.length -1]; }

isInStock = property('in_stock');
isLastInStock = _.compose(isInStock, last);
console.log(isLastInStock(CARS));


// Exercise 2:
// ============
// use _.compose(), _.prop() and _.head() to retrieve the name of the first car

function head(xs) { return xs[0]; }
name = _.partial(property('name'));
var nameOfFirstCar = _.compose(name, head);
console.log(nameOfFirstCar(CARS));



// Exercise 3:
// ============
// Use the helper function _average to refactor averageDollarValue as a composition
function sum (xs) { return _.reduce(xs, function (memo, item) { return memo + item;  }, 0);}
function _average(xs) { return sum(xs) / xs.length; } // <- leave be
function pluck (prop, xs) { return function (xs) { return xs.map(property(prop)); }; }

dollarValue = _.partial(pluck('dollar_value'));
var averageDollarValue = _.compose(_average, dollarValue);
console.log(averageDollarValue(CARS));

// Exercise 4:
// ============
// Write a function: sanitizeNames() using compose that returns a list of
// lowercase and underscored names: e.g: sanitizeNames(["Hello World"]) //=>
// ["hello_world"].

function replace(pattern, replacement, x) { return function (x) { return x.replace(pattern, replacement); }; }
var _underscore = replace(/\W+/g, '_'); //<-- leave this alone and use to sanitize
function lowercase(str) { return str.toLowerCase(); }

var sanitizeNames = _.compose(_underscore, lowercase);
console.log(String.prototype.toLowerCase("Bob Underhill"));
console.log(sanitizeNames("Bob Underhill"));


// Bonus 1:
// ============
// Refactor availablePrices with compose.

function formatMoney(number) { return '$' + number + '.00'; }
function formatPrices(xs) { return xs.map(formatMoney); }
function filter(property, xs) { return function (xs) { return xs.filter(function (x) { return x[property] === true; }); }; }
cars_in_stock = _.partial(filter('in_stock'));
prices = _.compose(formatPrices, dollarValue, cars_in_stock);


// Bonus 2:
// ============
// Refactor to pointfree. Hint: you can use _.flip()

function sortBy(property, xs) { return function (xs) { return xs.sort(function (a,b) { return (a[property] > b[property]); }); }; }
sort_by_horsepower = _.partial(sortBy('horsepower'));
fastestCar = _.compose(last, sort_by_horsepower);
console.log(fastestCar(CARS));
