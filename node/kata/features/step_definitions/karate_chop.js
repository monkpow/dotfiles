var myStepDefinitionsWrapper = function () {
  require('../../karate_chop.js');

  this.Given(/^I have the array (.*)$/, function(arg1, callback) {
  // express the regexp above with the code you wish you had
    ARG_ARRAY = parse_raw_array(arg1);
    callback();
  });


this.When(/^I call chop with the value (\d+)$/, function(arg1, callback) {
  // express the regexp above with the code you wish you had
    INDEX = arg1;
    CHOP_RESULT = chop(INDEX, ARG_ARRAY); 
    callback();
  });

  this.Then(/^I should recieve the result (.*)$/, function(arg1, callback) {
  // express the regexp above with the code you wish you had
    if (CHOP_RESULT == arg1){
      callback();
    } else {
      callback.fail(new Error("Expected chop("+INDEX+",["+ARG_ARRAY+"]) to return :"+arg1+", but instead was "+CHOP_RESULT));
    }
  });
};

parse_raw_array = function(PASSED_RAW){
  var results = [];
  PASSED_RAW = PASSED_RAW.replace(/(\[|\])/g, "");
  array_members = PASSED_RAW.split(",");
  for (var i =0; array_members[i]; i++){
    parsed_int = parseInt(array_members[i]);
    if (isNaN(parsed_int) && array_members[i].match(/\[.*\]/)){  
      results.push(process_as_array(array_members[i])); 
    } else {
      results.push(parsed_int);
    }
  }
  return results;
}

process_as_array = function(string_array){
  var list_of_values = string_array.replace(/(\[|\])/g, "");
  list_of_values = list_of_values.replace(/^\s*|\s*$/g, "");
  if (list_of_values == "" || typeof list_of_values == undefined){
    return [];
  }
  return parse_raw_array(list_of_values);
}

module.exports = myStepDefinitionsWrapper;

