class Api::V1::AnswersController < Api::V1::BaseController

  def index
    @answers = Answer.all
    respond_with @answers
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(user: current_resource_owner))
    authorize @answer
    respond_with @answer
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end