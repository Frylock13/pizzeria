//= require underscore
//= require lodash

//= require angular
//= require angular-animate

//= require angular-i18n/angular-locale_ru-ru
//= require angular-ui-router
//= require angular-ui-router-title
//= require angular-xeditable

//= require ng_states/module

//= require_self
//= require ./routes
//= require_tree ./services
//= require_tree ./controllers

### @ngInject ###
angular
  .module('admin', [
    'ngAnimate'
    'ngStates'
    'ui.router'
    'ui.router.title'
    'xeditable'
  ])
