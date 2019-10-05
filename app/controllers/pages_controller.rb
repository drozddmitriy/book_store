class PagesController < ApplicationController
  authorize_resource class: false

  def home
    @latest_books = Book.latest_books
  end
end
