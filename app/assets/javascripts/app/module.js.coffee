//= require underscore
//= require lodash

//= require angular
//= require angular-animate
//= require angular-sanitize

//= require angular-auto-focus
//= require angular-ladda
//= require angular-ui-bootstrap-bower
//= require autofill-event
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

$ ->
  angular.bootstrap(document.body, ['app']) unless $('body').hasClass('ng-scope')
