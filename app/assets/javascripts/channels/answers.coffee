$ ->
  answerlist = $('.single-question-answers__all-answers')
  App.answers = App.cable.subscriptions.create "AnswersChannel",
    received: (data) ->
      if data[0].user_id != gon.user_id
        console.log(data)
        answerlist.append(JST["templates/answer"](data))
