$(document).on 'ready page:load page:partial-load', ->
  $('.selectize-payment').selectize
    labelField: 'title'
    valueField: 'id'
  $('.selectize-dough').selectize
    labelField: 'title'
    valueField: 'id'
  $('.selectize-categories').selectize
    labelField: 'name'
    valueField: 'id'
    persist: false
    create: (input) ->
      id = 0
      $.ajax
        url: '/admin/ingredient_categories'
        type: 'POST'
        async: false
        data:
          ingredient_category:
            name: input
        dataType: 'json'
        success: (response) =>
          id = response.id
      return false if id == 0
      { id: id, name: input }
    render:
      option_create: (data, escape) ->
        addString = 'Создать категорию'
        return "<div class='create'>#{addString} <strong>#{escape(data.input)}</strong>&hellip;</div>"
