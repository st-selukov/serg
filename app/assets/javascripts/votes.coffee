ready = ->
  $('.vote-up-answer').on 'ajax:success', (e) ->
    console.log(e)
    votes_handler("answer", e)

  $('.vote-down-answer').on 'ajax:success', (e) ->
    votes_handler("answer", e)

  $('.vote-reset-answer').on 'ajax:success', (e) ->
    votes_handler("answer", e)

  $('.vote-up-question').on 'ajax:success', (e) ->
    votes_handler("question", e)

  $('.vote-down-question').on 'ajax:success', (e) ->
    votes_handler("question", e)

  $('.vote-reset-question').on 'ajax:success', (e) ->
    votes_handler("question", e)

$(document).ready(ready)
$(document).on('DOMNodeInserted', ready)

votes_handler = (votable, event) ->
  votes_sum = event.detail[0].votes_sum
  votable_id = event.detail[0].id
  $("##{votable}-" + votable_id + "-count-votes").html(votes_sum)
