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

$(document).on 'page:before-unload', ->
  angular.element('body').scope().$broadcast('$destroy')
$(document).on 'ready page:load page:partial-load', ->
  angular.bootstrap(document.body, ['app'])
