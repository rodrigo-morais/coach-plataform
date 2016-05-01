'use strict';

require('basscss/css/basscss.css');
require('basscss-colors/css/colors.css');
require('basscss-border-colors/css/border-colors.css');
require('font-awesome/css/font-awesome.css');

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm'),
    mountNode = document.getElementById('main'),
    configuration = configurationJSON;

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.embed(Elm.Main, mountNode, {getConfiguration: configuration});
