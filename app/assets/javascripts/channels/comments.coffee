$ ->
  App.comments = App.cable.subscriptions.create "CommentsChannel",
    received: (data) ->
      if data[0].user_id != gon.user_id
        currentCommentList = $('#'+ data[0].commentable_id + "-commentable-list")
        currentCommentList.append(JST["templates/comment"](data))