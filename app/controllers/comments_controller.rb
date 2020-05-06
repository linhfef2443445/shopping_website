class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @blog = Blog.find(comment_params[:blog_id])
    @comment = current_user.comments.build(comment_params)
    @comment.save
    @comments = @blog.comments
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :blog_id)
  end
end
