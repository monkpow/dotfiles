var objectStepDefinitionsWrapper = function () {

  this.Given(/^I have required (.*)$/, function(javascript_file, callback) {
  // express the regexp above with the code you wish you had
    try{
      this.file = require(javascript_file);
    } catch (e) {
      callback.fail(new Error("Could not find file "+file+". " + e));
    }
    callback();
  });

  this.Then(/^I should be able to access nikTest$/, function(callback) {
  // express the regexp above with the code you wish you had
    if (this.file) {
      callback();
    } else {
      callback.fail(new Error("Could not access generic javascript file."));
    }
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

  this.Then(/^Object method simple_member returns true$/, function(callback) {
    this.simple_member == "true"  ? callback() : callback.fail(new Error("Oh shit."))
  });

  this.Given(/^I have asked for an instance of doxie$/, function(callback) {
    this.doxie = require('scripts/doxie.js')
    callback();
  });

  this.Then(/^the returned object should respond to simple_member$/, function(callback) {
    this.doxie.simple_member ? callback() : callback.fail(new Error("oh snap!"));
  });

  this.Then(/^the returned object should respond to simple_method$/, function(callback) {
    this.doxie.simple_method() ? callback() : callback.fail(new Error("oh snap!"));
  });  

};

module.exports = objectStepDefinitionsWrapper;

