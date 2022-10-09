'use strict';

var Curry = require("../../lib/js/curry.js");

var each = import("../../lib/js/belt_List.js").then(function (m) {
      return m.forEach;
    });

var beltAsModule = import("../../lib/js/belt_List.js");

async function eachInt(list, f) {
  var each$1 = await each;
  return Curry._2(each$1, list, f);
}

exports.each = each;
exports.beltAsModule = beltAsModule;
exports.eachInt = eachInt;
/* No side effect */
