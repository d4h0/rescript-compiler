'use strict';

var Curry = require("../../lib/js/curry.js");

var each = import("../../lib/js/belt_List.js");

function eachInt(list, f) {
  var arg1 = function (each) {
    return Promise.resolve(Curry._2(each, list, f));
  };
  return each.then(arg1);
}

var beltAsModule = import("../../lib/js/belt_List.js");

exports.each = each;
exports.eachInt = eachInt;
exports.beltAsModule = beltAsModule;
/* No side effect */
