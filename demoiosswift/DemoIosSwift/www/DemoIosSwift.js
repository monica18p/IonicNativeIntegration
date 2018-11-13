var exec = require('cordova/exec');

var PLUGIN_NAME = 'demoIosSwift';

var demoIosSwift = {
    serviceName: "IonicBridge",
    // echo: function(phrase, cb) {
    //     exec(cb, null, PLUGIN_NAME, 'echo', [phrase]);
    // },
    // getDate: function(cb) {
    //     exec(cb, null, PLUGIN_NAME, 'getDate', []);
    // }

    echo: function (arg0, success, error) {
        exec(success, error, PLUGIN_NAME, 'echo', [arg0]);
    },
    echojs: function (arg0, success, error) {
        if (arg0 && typeof (arg0) === 'string' && arg0.length > 0) {
            success(arg0);
        } else {
            error('Empty message!');
        }
    },
    callToNative: function (successCallback, errorCallback, service, action, args) {
        exec(successCallback, errorCallback, service, action, [args]);
    },
    callFromIonic: function (args, successCallback, errorCallback) {
        exec(successCallback, errorCallback, this.serviceName, "callFromIonic", [args]);
    },
}

module.exports = demoIosSwift;

// exports.coolMethod = function (arg0, success, error) {
//     exec(success, error, 'DemoIosSwift', 'coolMethod', [arg0]);
// };

// exports.echo = function (arg0, success, error) {
//     exec(success, error, 'ModusEchoSwift', 'echo', [arg0]);
// };

// exports.echojs = function (arg0, success, error) {
//     if (arg0 && typeof (arg0) === 'string' && arg0.length > 0) {
//         success(arg0);
//     } else {
//         error('Empty message!');
//     }
// };
