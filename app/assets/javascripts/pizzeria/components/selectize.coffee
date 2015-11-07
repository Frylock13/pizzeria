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

$(document).on 'ready page:load page:partial-load', ->
  $('.selectize-dough').selectize
    labelField: 'title'
    valueField: 'id'

  $('.selectize-doughs').selectize
    labelField: 'name'
    valueField: 'id'

  $('.selectize-feature-values').selectize(
    creatableElements('feature_value', 'feature_values', 'Создать значение атрибута')
  )

  $('.selectize-features').selectize(
    creatableElements('feature', 'features', 'Создать атрибут')
  )

  $('.selectize-ingredient-categories').selectize(
    creatableElements('ingredient_category', 'ingredient_categories', 'Создать категорию')
  )

  $('.selectize-payment').selectize
    labelField: 'title'
    valueField: 'id'

  $('.selectize-product-categories').selectize(
    creatableElements('product_category', 'product_categories', 'Создать категорию')
  )

  $('.selectize-visibility').selectize()
