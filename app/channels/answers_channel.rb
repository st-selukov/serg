class AnswersChannel < ApplicationCable::Channel
  def follow(data)
    stream_for "answers"
  end
end
