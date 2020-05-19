module Manager
  class CommentsController < Manager::BaseController
    load_and_authorize_resource

    def index
      @comments = Comment.page(params[:page]).order(created_at: :desc)
    end

    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
        flash[:success] = "Comment Deleted"
        redirect_to manager_comments_path
      else
        flash[:error] = "Fail to delete comment"
        redirect_to manager_comments_path
      end
    end
  end
end
