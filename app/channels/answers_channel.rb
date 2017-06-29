class AnswersChannel < ApplicationCable::Channel
  def answers(data)
    stream_from "questions/#{data['question_id']}/answers"
  end
end
