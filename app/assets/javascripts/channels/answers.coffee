$ ->
  answerlist = $('.single-question-answers__all-answers')
  App.answers = App.cable.subscriptions.create "AnswersChannel",
    connected: ->
      question_id = $('.single-question').data('question_id')
      @perform 'answers', question_id: question_id

    received: (data) ->
      if data['answer'].user_id != gon.user_id
        answerlist.append(JST["templates/answer"](data))
        $.each(data['attachments'], (i, v) ->
          $('#answer-attached-list-' + data['answer'].id).
          append(JST["templates/attachment"]({obj: v, user_id: data['answer_user.id']})))