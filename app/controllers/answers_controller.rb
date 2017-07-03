class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:update, :destroy, :best_answer]
  after_action :publish_answer, only: [:create]

  respond_to :js, :json

  def create
    respond_with @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def edit
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
    @question = @answer.question
  end

  def destroy
    respond_with @answer.destroy if current_user.author_of?(@answer)
  end

  def best_answer
    @answer.set_best if current_user.author_of?(@answer.question)
    respond_with @answer, location: @answer.question
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast("questions/#{@answer.question.id}/answers",
    { answer: @answer, answer_user: @answer.user, attachments: @answer.attachments })
  end
end
