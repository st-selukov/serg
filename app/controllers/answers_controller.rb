class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:destroy]

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    if @answer.save
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to @answer.question
    else
      render 'questions/show'
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
