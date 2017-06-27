class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable
  before_action :find_comment, only: [:destroy]

  def create
    @comment = @commentable.comments.create(comment_params.merge(user_id: current_user.id))
    ActionCable.server.broadcast('comments', [@comment, @comment.user.email])
  end

  def destroy
    @comment.destroy
  end

  private

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
