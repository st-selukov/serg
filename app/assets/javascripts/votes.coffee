ready = ->
  $('.vote-up-link, .vote-down-link').on 'ajax:success', (e) ->
    votes_handler(e)
  .on 'ajax:error', (e) ->
    votes_error_handler(e)

  $('.vote-reset-link').on 'ajax:success', (e) ->
    votes_handler(e)

$(document).ready(ready)
$(document).on('DOMNodeInserted', ready)

votes_handler = (event) ->
  votes_sum = event.detail[0][0].votes_sum
  votable_id = event.detail[0][0].id
  votable = event.detail[0][1]
  $("##{votable}-" + votable_id + "-count-votes").html(votes_sum)

votes_error_handler = (event) ->
  votable_id = event.detail[0][0].id
  votable = event.detail[0][1]
  error = event.detail[0][2]
  modal_window = $("##{votable}-" + votable_id + "-modal-window")
  modal_window.show().html(error)
  modal_window.delay(500).fadeOut(300)