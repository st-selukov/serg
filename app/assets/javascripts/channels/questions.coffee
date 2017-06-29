$ ->
  questionlist = $('.articles-all-questions-wrapper')
  App.questions = App.cable.subscriptions.create "QuestionsChannel",
    received: (data) ->
      if data['question'].user_id != gon.user_id
        questionlist.prepend(JST["templates/question"](data))