# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(review_params[:product_id])
    @review = current_user.reviews.build(review_params)
    @review.save
    @reviews = @product.reviews
  end

  private

  def review_params
    params.require(:review).permit(:content, :rate, :product_id)
  end
end
