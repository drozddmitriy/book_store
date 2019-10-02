class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:success] = I18n.t('controllers.reviews.thanks_for_review')
    else
      flash[:danger] = I18n.t('controllers.reviews.reviews_not_applied')
    end

    redirect_to book_path(params[:book_id])
  end

  private

  def review_params
    params.require(:review).permit(:comment, :title, :book_id, :user_id, :rating)
  end
end
