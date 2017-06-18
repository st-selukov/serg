ready = ->
  $('.vote-up-answer-link').on('click').bind 'ajax:success', (e) ->
    answer = $.parseJSON(e.detail[2].responseText)
    $('#answer-' + answer.id + '-count-votes').html(answer.votes_sum)

  $('.vote-down-answer-link').on('click').bind 'ajax:success', (e) ->
    answer = $.parseJSON(e.detail[2].responseText)
    $('#answer-' + answer.id + '-count-votes').html(answer.votes_sum)

  $('.vote-reset-answer-link').on('click').bind 'ajax:success', (e) ->
    answer = $.parseJSON(e.detail[2].responseText)
    $('#answer-' + answer.id + '-count-votes').html(answer.votes_sum)

  $('.vote-up-question-link').on('click').bind 'ajax:success', (e) ->
    question = $.parseJSON(e.detail[2].responseText)
    $('#question-' + question.id + '-count-votes').html(question.votes_sum)

  $('.vote-down-question-link').on('click').bind 'ajax:success', (e) ->
    question = $.parseJSON(e.detail[2].responseText)
    $('#question-' + question.id + '-count-votes').html(question.votes_sum)

  $('.vote-reset-question-link').on('click').bind 'ajax:success', (e) ->
    question = $.parseJSON(e.detail[2].responseText)
    $('#question-' + question.id + '-count-votes').html(question.votes_sum)

$(document).ready(ready)
$(document).on('DOMNodeInserted', ready)

