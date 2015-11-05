$(document).on 'ready page:load page:partial-load', ->
  summernotes = $('.summernote')
  if summernotes.length
    summernotes.each ->
      console.log $(this)
      $(this).summernote
        height: 300
        lang: 'ru-RU'
        toolbar: [
          ['style', ['bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear']],
          ['para', ['style', 'paragraph', 'ul', 'ol']],
          ['insert', ['link', 'picture', 'video', 'table', 'hr']],
          ['misc', ['undo', 'redo', 'fullscreen', 'codeview']],
          ['help', ['help']]
        ]
      $(this).code $(this).val()
      $(this).closest('form').submit =>
        $(this).val $(this).code()
        true
