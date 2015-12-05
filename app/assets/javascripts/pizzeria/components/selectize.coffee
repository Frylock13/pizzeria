creatableElements = (elem, elems, text) ->
  dataForElem = (input) ->
    data = {}
    data[elem] = { name: input }
    data
  {
    labelField: 'name'
    valueField: 'id'
    persist: false
    delimiter: null
    create: (input) ->
      id = 0
      $.ajax
        url: "/admin/#{elems}"
        type: 'POST'
        async: false
        data: dataForElem(input)
        dataType: 'json'
        success: (response) =>
          id = response[elem].id
      return false if id == 0
      { id: id, name: input }
    render:
      option_create: (data, escape) ->
        return "<div class='create'>#{text} <strong>#{escape(data.input)}</strong>&hellip;</div>"
  }

initSelectize = ->
  $('select.selectize-dough:not(.selectized)').selectize
    labelField: 'title'
    valueField: 'id'

  $('select.selectize-doughs:not(.selectized)').selectize
    labelField: 'name'
    valueField: 'id'
    onChange: (value) ->
      $('#pizza_attributes').ladda().ladda('start')
      form = $(this.$control[0]).closest('form')
      action = form.attr('action')
      form.attr('action', "#{action}/recalculate").submit().attr('action', action) if action == '/pizzas'

  $('select.selectize-feature-values:not(.selectized)').selectize(
    creatableElements('feature_value', 'feature_values', 'Создать значение атрибута')
  )

  $('select.selectize-features:not(.selectized)').selectize(
    creatableElements('feature', 'features', 'Создать атрибут')
  )

  $('select.selectize-ingredient-categories:not(.selectized)').selectize(
    creatableElements('ingredient_category', 'ingredient_categories', 'Создать категорию')
  )

  changeOrderAddress = (value) ->
    block = $('#address_attributes').first()
    switch value
      when 'attributes'
        block.removeClass('hide')
        block.find('input').prop('disabled', false)
      else
        block.addClass('hide')
        block.find('input').prop('disabled', true)

  $('select.selectize-order-address:not(.selectized)').selectize
    labelField: 'title'
    valueField: 'id'
    onChange: (value) ->
      changeOrderAddress(value)
    onInitialize: (data) ->
      changeOrderAddress(this.$input[0].value)

  changeOrderBooking = (value) ->
    block = $('#booked_attributes').first()
    switch value
      when 'accepted'
        block.addClass('hide')
        block.find('input').prop('disabled', true)
      when 'booked'
        block.removeClass('hide')
        block.find('input').prop('disabled', false)

  $('select.selectize-order-booking:not(.selectized)').selectize
    labelField: 'title'
    valueField: 'id'
    onChange: (value) ->
      changeOrderBooking(value)
    onInitialize: (data) ->
      changeOrderBooking(this.$input[0].value)

  changeOrderPayment = (value) ->
    block = $('#payment_bonus_points').first()
    block_cash = $('#payment_cash').first()
    switch value
      when 'bonus_points'
        block.removeClass('hide')
        block_cash.addClass('hide')
      else
        block.addClass('hide')
        block_cash.removeClass('hide')

  $('select.selectize-order-payment:not(.selectized)').selectize
    labelField: 'title'
    valueField: 'id'
    onChange: (value) ->
      changeOrderPayment(value)
    onInitialize: (data) ->
      changeOrderPayment(this.$input[0].value)

  changeOrderProfile = (value) ->
    block = $('#receiving_profile_attributes').first()
    switch value
      when 'attributes'
        block.removeClass('hide')
        block.find('input').prop('disabled', false)
      else
        block.addClass('hide')
        block.find('input').prop('disabled', true)

  $('select.selectize-order-profile:not(.selectized)').selectize
    labelField: 'title'
    valueField: 'id'
    onChange: (value) ->
      changeOrderProfile(value)
    onInitialize: (data) ->
      changeOrderProfile(this.$input[0].value)

  $('select.selectize-pizzas:not(.selectized)').selectize
    labelField: 'name'
    valueField: 'id'

  $('select.selectize-product-categories:not(.selectized)').selectize(
    creatableElements('product_category', 'product_categories', 'Создать категорию')
  )

  $('select.selectize-visibility:not(.selectized)').selectize()

$(document).on 'ready page:load page:partial-load', initSelectize
$(document).on 'ready', ->
  $('#dynamic_modal').on 'shown.bs.modal', initSelectize
