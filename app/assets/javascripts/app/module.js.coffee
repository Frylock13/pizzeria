//= require underscore
//= require angular

//= require_self
//= require_tree ./controllers

angular.module('app', [])

$(document).on 'page:before-change page:before-unload', ->
  angular.element('body').scope().$broadcast('$destroy') if angular.element('body').scope()
$(document).on 'ready page:load page:partial-load', ->
  angular.bootstrap(document.body, ['app'])
