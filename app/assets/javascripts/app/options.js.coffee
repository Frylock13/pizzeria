### @ngInject ###
TurbolinksOptions = ($compile, $rootScope, $document) ->
  $document.on 'page:partial-load', ->
    body = angular.element('body')
    $compile(body.html())($rootScope)

angular
  .module('app')
  .run(TurbolinksOptions)
