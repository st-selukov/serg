ready = ->
  $('.vote-up-answer-link').on('click').bind 'ajax:success', (e, data, status, xhr) ->
    console.log("data:", data)
    answer = $.parseJSON(xhr.responseText)
    $('#answer-' + answer.id + '-count-votes').html(answer.votes_sum)

$(document).ready(ready)
$(document).on('DOMNodeInserted', ready)
