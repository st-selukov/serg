ready = ->
  $('.delete-curent-answer').click (e) ->
    e.preventDefault()
    answer = $(this).data('answerId')
    $('#current_answer-' + answer).hide()

  $('.current-answer-link-edit').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#update-answer-form-' + answer_id).show();

  $('.delete_attachment').click (e) ->
    e.preventDefault();
    a_id = $(this).data('attachmentId')
    $("#attachment-file-" + a_id).hide();

$(document).ready(ready)
$(document).on('DOMNodeInserted', ready)
