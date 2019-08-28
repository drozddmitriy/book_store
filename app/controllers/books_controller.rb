class BooksController < ApplicationController
  def index
    @categories = Category.all
    
    @books = Book.first(8)
  end

  def show
    @book = Book.find_by(id: params[:id])
    # binding.pry
  end
end
