//= require underscore
//= require angular
//= require angular-animate

//= require_self
//= require_tree ./services
//= require_tree ./controllers

angular.module('app', [
    'ngAnimate'
  ])

# $(document).on 'page:before-change page:before-unload', ->
#   angular.element('body').scope().$broadcast('$destroy') if angular.element('body').scope()
$(document).on 'ready page:load page:partial-load', ->
  angular.bootstrap(document.body, ['app']) unless angular.element('body').scope()
