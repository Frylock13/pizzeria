$(document).on 'ready page:load page:partial-load', ->
  $('.summernote').summernote({
    height: 300,
    toolbar: [
      ['style', ['bold', 'italic', 'underline', 'clear']],
      ['font', ['strikethrough', 'superscript', 'subscript']],
      ['fontsize', ['fontsize']],
      ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['height', ['height']],
      ['insert', ['link', 'table', 'hr']],
      ['misc', ['fullscreen', 'codeview', 'undo', 'redo']]
    ],
    onChange: (contents, $editable) ->
      $($editable.context).next().next().val(contents)
  })
