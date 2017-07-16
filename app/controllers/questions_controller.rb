class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  after_action :publish_question, only: [:create]

  respond_to :html

  def index
    respond_with @questions = Question.all

  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit; end

  def update
    @question.update(question_params)
    respond_with @question, location: @question
    authorize @question
  end

  def destroy
    respond_with @question.destroy
    authorize @question
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast('questions',
                                 {question: @question, question_user: @question.user})
  end
end
