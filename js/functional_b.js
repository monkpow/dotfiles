var _ = require('underscore');

/*
 *  <ul class="no-bullet switches">
 *    <li>
 *      <div class="tiny round switch">
 *        <input type="checkbox"
 *         name="values"
 *         value="27362c47-a644-4dbb-b4f9-4766cd08d7ca"
 *         id="g27362c47-a644-4dbb-b4f9-4766cd08d7ca"
 *       >
 *       <!-- this one is for foundation. -->
 *       <label for="g27362c47-a644-4dbb-b4f9-4766cd08d7ca">
 *       </label>
 *       </div>
 *       <!-- this one is for users -->
 *       <label for="g27362c47-a644-4dbb-b4f9-4766cd08d7ca">Point of Sale</label>
 *    </li>
 *  </ul>
*/


var data = {
  "guid":"27362c47-a644-4dbb-b4f9-4766cd08d7ca",
  "name":"pos",
  "color":"green",
  "description":"",
  "displayName":"Point of Sale"
}

// convert to human readable.   tools for reading to html, writing from html
// extract useful variables and compose that to the function


function label(forID) {
  return ['<label for ', forID, '>'].join('"');
}

function extract(data, property) {
  return function (property) {
    return data[property];
  };
}

console.log(data);
var opts = extract(data);
console.log(label((opts('guid'))));

var labeller = _.compose(label, opts);
console.log(labeller('guid'));


