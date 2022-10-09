'use strict';

var Curry = require("../../lib/js/curry.js");

var each = import("../../lib/js/belt_List.js").then(function (m) {
      return m.forEach;
    });

function eachInt(list, f) {
  var arg1 = function (each) {
    return Promise.resolve(Curry._2(each, list, f));
  };
  return each.then(arg1);
}

var beltAsModule = import("../../lib/js/belt_List.js");

async function eachIntAsync(list, f) {
  var each$1 = await each;
  return Curry._2(each$1, list, f);
}

exports.each = each;
exports.eachInt = eachInt;
exports.beltAsModule = beltAsModule;
exports.eachIntAsync = eachIntAsync;
/* No side effect */
