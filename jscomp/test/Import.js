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

function eachLazy(param) {
  return import("../../lib/js/belt_List.js").then(function (m) {
              return m.forEach;
            });
}

function eachIntLazy(list, f) {
  var obj = import("../../lib/js/belt_List.js").then(function (m) {
        return m.forEach;
      });
  var arg1 = function (each) {
    return Promise.resolve(Curry._2(each, list, f));
  };
  return obj.then(arg1);
}

exports.each = each;
exports.eachInt = eachInt;
exports.beltAsModule = beltAsModule;
exports.eachIntAsync = eachIntAsync;
exports.eachLazy = eachLazy;
exports.eachIntLazy = eachIntLazy;
/* No side effect */
