### @ngInject ###
AuthController = (processStatesProvider, Restangular, $rootElement, $scope) ->

  goTo = (step) =>
    @errors = {}
    switch step
      when 'sign_in'
        @elems.form_sign_in = true
        @elems.button_sign_up = true
        @elems.button_password_reset = true
        @elems.form_password_reset = false
        @elems.form_sign_up = false
        @elems.button_sign_in = false
      when 'sign_up'
        @elems.form_sign_up = true
        @elems.button_sign_in = true
        @elems.button_password_reset = true
        @elems.form_password_reset = false
        @elems.form_sign_in = false
        @elems.button_sign_up = false
      when 'password_reset'
        @elems.form_password_reset = true
        @elems.button_sign_up = true
        @elems.button_sign_in = true
        @elems.form_sign_in = false
        @elems.form_sign_up = false
        @elems.button_password_reset = false
      when 'success'
        @elems.form_password_reset = false
        @elems.form_sign_in = false
        @elems.form_sign_up = false
        @elems.button_password_reset = false
        @elems.button_sign_in = false
        @elems.button_sign_up = false

  goToPasswordReset = =>
    @message = '<b>Не помните пароль?</b><br/>Напишите почту, под которой регистрировались'
    goTo 'password_reset'

  goToSignIn = =>
    @message = '<b>Попробуем войти еще раз</b><br/>Введите почту и пароль'
    goTo 'sign_in'

  goToSignUp = =>
    @message = '<b>Впервые у нас? Расскажите о себе</b><br/>Введите свое имя, почту и придумайте пароль'
    goTo 'sign_up'

  submitPasswordReset = =>
    @states.password_reset.setPending()
    Restangular
      .all('password_resets')
      .post(email: @data.email)
      .then (response) =>
        if response.status == 'success'
          @message = '<b>Мы выслали вам письмо с инструкциями на указанную почту</b><br/>Проверьте свой почтовый ящик'
          goTo 'success'
          @states.password_reset.setSucceeded()
        if response.status == 'error'
          @message = '<b>Пользователя с таким email в системе нет</b><br/>Проверьте, верно ли введен email. Возможно вам стоит зарегистрироваться?'
          @states.password_reset.setFailed()
      , (response) =>
        @message = response.data.message || '<b>Ошибка на сервере</b><br/>Попробуйте еще раз:'
        @states.password_reset.setFailed()

  submitSignIn = =>
    @states.sign_in.setPending()
    Restangular
      .all('user_sessions')
      .post(
        user:
          email: @data.email
          password: @data.password
      ).then (response) =>
        if response.status == 'success'
          @message = '<b>Отлично, данные получены</b><br/>Теперь вы получите доступ к странице'
          goTo 'success'
          @states.sign_in.setSucceeded()
          window.setTimeout (->
            window.location = '/admin'
            # .reload()
            return
          ), 1000
        if response.status == 'error'
          @message = '<b>Пароль или email не подходят</b><br/>Попробуйте еще раз:'
          @states.sign_in.setFailed()
      , (response) =>
        @message = '<b>Ошибка на сервере</b><br/>Попробуйте еще раз:'
        @states.sign_in.setFailed()

  submitSignUp = =>
    @states.sign_up.setPending()
    Restangular
      .all('users')
      .post(
        user:
          email: @data.email
          password: @data.password
          password_confirmation: @data.password
          profile_attributes:
            first_name: @data.first_name
      ).then (response) =>
        if response.status == 'success'
          @message = '<b>Отлично, все данные сохранены</b><br/>Теперь вы получите доступ к странице'
          goTo 'success'
          @states.sign_up.setSucceeded()
          window.setTimeout (->
            window.location = '/admin'
            # .reload()
            return
          ), 1000
        if response.status == 'error'
          @message = '<b>В данных есть ошибки</b><br/>Исправьте их:'
          @errors = response.errors
          @states.sign_up.setFailed()
      , (response) =>
        @message = '<b>Ошибка на сервере</b><br/>Попробуйте еще раз:'
        @states.sign_up.setFailed()

  init = =>
    @message = '<b>Вы перешли на защищенную страницу</b><br/>Представьтесь, пожалуйста:'
    goTo 'sign_in'

  # # # # # # # # # # # # # # # # # # #

  @data =
    email: undefined
    password: undefined
    first_name: undefined
  @elems =
    button_password_reset: false
    button_sign_in: false
    button_sign_up: false
    form_password_reset: false
    form_sign_in: false
    form_sign_up: false
  @errors = {}
  @message = null
  @states =
    password_reset: processStatesProvider.getInstance()
    sign_in: processStatesProvider.getInstance()
    sign_up: processStatesProvider.getInstance()
  @goToPasswordReset = goToPasswordReset
  @goToSignIn = goToSignIn
  @goToSignUp = goToSignUp
  @submitPasswordReset = submitPasswordReset
  @submitSignIn = submitSignIn
  @submitSignUp = submitSignUp
  init()
  return

angular
  .module('app')
  .controller('AuthController', AuthController)
