$ ->
  App.comments = App.cable.subscriptions.create "CommentsChannel",
    connected: ->
      question_id = $('.single-question').data('question_id')
      @perform 'comments', question_id: question_id
    received: (data) ->
      if data['comment'].user_id != gon.user_id
        currentCommentList = $('#'+ data['comment'].commentable_id + "-commentable-list")
        currentCommentList.append(JST["templates/comment"](data))