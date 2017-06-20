ready = ->
  $('.vote-up-link').on 'ajax:success', (e, xhr, data) ->
    votes_handler(e, xhr, data)

  $('.vote-down-link').on 'ajax:success', (e) ->
    votes_handler(e)

  $('.vote-reset-link').on 'ajax:success', (e) ->
    votes_handler(e)

$(document).ready(ready)
$(document).on('DOMNodeInserted', ready)

votes_handler = (event,xhr, data) ->
  console.log(event,xhr, data)
  votes_sum = event.detail[0][0].votes_sum
  votable_id = event.detail[0][0].id
  votable = event.detail[0][1]
  $("##{votable}-" + votable_id + "-count-votes").html(votes_sum)
