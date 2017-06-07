class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:update, :destroy, :best_answer]

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def edit
  end

  def update
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    else
      render status: :forbidden
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
    else
      render status: :forbidden
    end
  end

  def best_answer
    if current_user.author_of?(@answer.question)
      @answer.set_best
      redirect_to @answer.question
    else
      render status: :forbidden
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
