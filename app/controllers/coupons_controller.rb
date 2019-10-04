class CouponsController < ApplicationController
  def update
    coupon = Coupon.find_by(coupon: params[:coupon], active: true)

    if coupon
      coupon.update(order_id: current_order.id, active: false)
      flash[:success] = "Coupon applied!"
    else
      flash[:danger] = "Coupon not applied"
    end

    redirect_to line_items_path
  end
end
