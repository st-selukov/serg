class AnswersController < ApplicationController
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:destroy]

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    @answer.save
    redirect_to question_path(@question)
  end

  def destroy
    if @answer.user == current_user
      @answer.destroy
      redirect_to @answer.question
    else
      redirect_to root_url
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
