$(document).on 'ready page:load page:partial-load', ->
  items = $('.sortable-list')
  if items.length
    items.each ->
      $(this).sortable
        animation: 150
        handle: '.draggable-zone'
        onSort: (event) =>
          el = $(event.item)
          el.addClass('position-pending')
          params = {}
          params[el.data('model')] = { position: event.newIndex+1 }
          $.ajax(
            url: el.data('url')
            method: 'PATCH'
            data: params
          ).done =>
            el.removeClass('position-pending')
