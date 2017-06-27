$ ->
  questionlist = $('.articles-all-questions-wrapper')
  App.questions = App.cable.subscriptions.create "QuestionsChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      if data[0].user_id != gon.user_id
        questionlist.prepend(JST["templates/question"](data))