class CouponsController < ApplicationController
  load_and_authorize_resource

  def update
    coupon = Coupon.find_by(coupon: params[:coupon], active: true)

    if coupon
      coupon.update(order_id: current_order.id)
      session[:coupon_id] = coupon.id
      flash[:success] = "Coupon applied!"
    else
      flash[:danger] = "Coupon not applied"
    end

    redirect_to line_items_path
  end
end
