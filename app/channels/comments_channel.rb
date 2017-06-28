class CommentsChannel < ApplicationCable::Channel
  def comments(data)
    stream_from stream_from "questions/#{data['question_id']}"
  end
end
