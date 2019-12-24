class CouponsController < ApplicationController
  def update
    coupon = Coupon.find_by(coupon: params[:coupon], active: true)

    if coupon
      coupon.update(order_id: current_order.id)
      session[:coupon_id] = coupon.id
      flash[:success] = I18n.t('controllers.coupons.coupon_applied')
    else
      flash[:danger] = I18n.t('controllers.coupons.coupon_not_applied')
    end

    redirect_to line_items_path
  end
end
