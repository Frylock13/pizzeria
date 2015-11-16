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

  $('select.selectize-feature-values:not(.selectized)').selectize(
    creatableElements('feature_value', 'feature_values', 'Создать значение атрибута')
  )

  $('select.selectize-features:not(.selectized)').selectize(
    creatableElements('feature', 'features', 'Создать атрибут')
  )

  $('select.selectize-ingredient-categories:not(.selectized)').selectize(
    creatableElements('ingredient_category', 'ingredient_categories', 'Создать категорию')
  )

  $('select.selectize-payment:not(.selectized)').selectize
    labelField: 'title'
    valueField: 'id'

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
