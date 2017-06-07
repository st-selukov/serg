ready = ->
    $('.delete-curent-answer').click (e) ->
      e.preventDefault()
      answer = $(this).data('answerId')
      $('#current_answer-'+answer).hide()

    $('.current-answer-link-edit').click (e) ->
      e.preventDefault();
      $(this).hide();
      answer_id = $(this).data('answerId')
      $('form#update-answer-form-' + answer_id).show();

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
$(document).on('DOMNodeInserted', ready)
