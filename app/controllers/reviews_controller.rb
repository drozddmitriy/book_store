class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @book = Book.find(params[:book_id])

    if @review.save
      flash[:success] = 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      flash[:danger] = "Reviews not appliedd!!!"
    end

    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :title, :book_id, :user_id, :rating)
  end
end
