class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable
  before_action :find_comment, only: [:destroy]

  def create
    @comment = @commentable.comments.create(comment_params.merge(user_id: current_user.id))
    publish_comment
  end

  def destroy
    @comment.destroy
    authorize @comment
  end

  private

  def publish_comment
    return if @comment.errors.any?
    if @commentable.instance_of?(Question)
      ActionCable.server.broadcast("questions/#{@commentable.id}",
                                   {comment: @comment, comment_user: @comment.user})
    elsif @commentable.instance_of?(Answer)
      ActionCable.server.broadcast("questions/#{@commentable.question.id}",
                                   {comment: @comment, comment_user: @comment.user})
    end
  end

  def find_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
