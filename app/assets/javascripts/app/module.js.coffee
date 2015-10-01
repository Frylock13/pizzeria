//= require underscore
//= require lodash

//= require angular
//= require angular-animate
//= require angular-sanitize

//= require angular-auto-focus
//= require autofill-event
//= require ladda/spin.min
//= require ladda
//= require angular-ladda
//= require angular-ui-bootstrap-bower
//= require restangular

//= require ng_states/module

//= require_self
//= require_tree ./controllers

angular
  .module('app', [
    'angular-ladda'
    'mp.autoFocus'
    'ngAnimate'
    'ngSanitize'
    'ngStates'
    'restangular'
    'ui.bootstrap'
  ])
