class AnswersController < ApplicationController
  before_action :load_question

  def create
    @answer = @question.answers.new(answer_params)
    @answer.save
    redirect_to question_path(@question)
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
