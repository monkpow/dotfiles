/*
 * http://jasmine.github.io/2.0/custom_matcher.html
 */

var customMatchers = {

  toBeInstanceOf: function (util, customEqualityTesters) {
    return {
      compare: function (actual, expected) {
        var instanceOf = actual instanceof expected;
        return {
          pass: instanceOf
        };
      }
    };
  },

  toMatchObject: function (util, customEqualityTesters) {
    return {
      compare: function (actual, expected) {
        try {
          // trivial underscore call.
          _([]);
        } catch (error) {
          throw new SyntaxError('This matcher requires underscore.js');
        }

        var keys, sameSize, unmatchedMembers, hasExactKeys, prop, results = {};

        results.pass = _(actual).isEqual(expected);

        if (!results.pass) {
          results.message = ['Expected objects to match:',
                             'Actual:   ' + JSON.stringify(actual),
                             'Expected: ' + JSON.stringify(expected)].join('\n');
        }
        return results;
      }
    };
  },

  toHaveExactKeys:  function (util, customEqualityTesters) {
    return {
      compare: function (actual, expected) {
        // takes an actual object and and expected list of keys
        // ensures the object has only those keys

        try {
          // trivial underscore call.
          _([]);
        } catch (error) {
          throw new SyntaxError('This matcher requires underscore.js');
        }

        var keys, sameSize, unmatchedMembers, hasExactKeys;

        keys = _(actual).keys();

        sameSize = (keys.length === expected.length);
        unmatchedMembers = _(expected).reject(function (attribute) {
          return keys.indexOf(attribute) >= 0;
        });

        hasExactKeys = sameSize && _(unmatchedMembers).isEmpty();
        return {
          pass: hasExactKeys
        };
      }
    };
  }

};

// In this case, instead of adding to beforeEach, I want to disable this
// functionality for the entire lifecycle of the test suite.   The specific use
// case this solves is that liveUpdate sets a timeout which calls navigate on
// an interval.   After the test suite has completed there is a lingering
// timeout calling to navigate.  This causes the test suite to change urls,
// making 'refresh' useless.

console.log('NOTE: Push state functionality (re-writing urls) is disabled by test suite.');
Backbone.history.history.pushState = function () {};

beforeEach(function () {
  jasmine.addMatchers(customMatchers);
});
