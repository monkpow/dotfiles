// features/step_definitions/myStepDefinitions.js
var myStepDefinitionsWrapper = function () {
  this.World = require("../support/world.js").World; // overwrite default World constructor

  this.Given(/^I am on my local node server$/, function (callback) {
    this.visit('http://127.0.0.1:8124/', callback);
  });

  this.Then(/^I should see "(.*)" as the page title$/, function(title, callback) {
    if (!this.browser.response[2]=="Hello World\n")
    callback.fail(new Error("Expected to be on page with title " + title));
    else
    callback();
  });

  this.Given(/^I have loaded a javascript file$/, function(callback) {
    this.nik = require('scripts/nikTest.js');
    callback();
  });

  this.Then(/^I should be able to manipulate the object$/, function(callback) {
    if (this.nik.sum(1,2)){
      callback();
    }else{
      callback.fail(new Error("Expected to be able to call sum"));
    }
  });

  this.Given(/^I have a javascript fixture$/, function(callback) {
    this.visit('http://localhost:8124/static/index.html', callback);
  });

  this.Then(/^node should load and return it$/, function(callback) {
    if (this.browser.response[2].match(/oh boy/)){
      callback();
    }else{
      callback.fail(new Error("Expected to see 'oh boy'"));
    }
  });

};

module.exports = myStepDefinitionsWrapper;
