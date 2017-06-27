ready = ->
  $('.open-comments').click (e) ->
    parent_id= $(this).data('open')
    $("#comment-wrapper-"+ parent_id).show()

  $('.delete-comment').click (e) ->
    e.preventDefault()
    comment_id = $(this).data('commentId')
    $("#comment-" + comment_id).hide()

$(document).ready(ready)
$(document).on('DOMNodeInserted', ready)