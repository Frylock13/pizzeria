### @ngInject ###
PasswordResetsController = (processStatesProvider, Restangular, $rootElement, $scope) ->

  goTo = (step) =>
    @errors = {}
    switch step
      when 'password_reset'
        @elems.form_password_reset = true
      when 'success'
        @elems.form_password_reset = false

  submitPassword = (token) =>
    @states.password_reset.setPending()
    Restangular
      .one('password_resets', token)
      .patch(user: @data)
      .then (response) =>
        if response.status == 'success'
          @message = '<b>Отлично, ваш пароль обновлен!</b><br/>Сейчас вы будете перенаправлены в админку'
          goTo 'success'
          @states.password_reset.setSucceeded()
          window.setTimeout (->
            window.location = '/admin'
            return
          ), 1000
      , (response) =>
        @message = response.data.message || '<b>Ошибка на сервере</b><br/>Попробуйте еще раз:'
        @states.password_reset.setFailed()

  init = =>
    @message = '<b>Ваш пароль успешно обнулен</b><br/>Введите новый, пожалуйста:'
    goTo 'password_reset'

  # # # # # # # # # # # # # # # # # # #

  @data =
    password: undefined
  @elems =
    form_password_reset: false
  @errors = {}
  @message = null
  @states =
    password_reset: processStatesProvider.getInstance()
  @submitPassword = submitPassword
  init()
  return

angular
  .module('app')
  .controller('PasswordResetsController', PasswordResetsController)
