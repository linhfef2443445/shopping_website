module Manager
  class ReviewsController < Manager::BaseController
    load_and_authorize_resource

    def index
      @reviews = Review.page(params[:page]).order(created_at: :desc)
    end

    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      redirect_to manager_reviews_path, success: "Review Deleted"
    end
  end
end