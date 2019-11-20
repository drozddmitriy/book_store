class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :current_order

  private

  def current_order
    order = Order.find_or_create_by(id: session[:order_id])

    session[:order_id] = order.id
    order
  end
end
