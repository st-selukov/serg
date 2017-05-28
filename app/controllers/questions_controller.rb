class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :load_question, only: [:show, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @answers = @question.answers.all
    @answer = @question.answers.build
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to questions_path
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
