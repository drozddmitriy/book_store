class CheckoutUpdateService
  def initialize(step, order, user, params, session)
    @user = user
    @order = order
    @step = step
    @params = params
    @session = session
  end

  def call
    public_send(@step.to_s)
  end

  def addresses
    @order.set_order_use_billing(@params[:addresses_form][:use_billing])

    @addresses = AddressesForm.new(@user, @order, addresses_params)
    @addresses.save
  end

  def delivery
    @order.update_attributes(order_params)
    # flash[:danger] = 'Please choose delivery method!' if @order.delivery_id.nil?
  end

  def payment
    @credit_card = CreditCard.new(credit_card_params)
    # render_wizard unless @credit_card.save
    @credit_card.save
    @order.update_attributes(credit_card_id: @credit_card.id)
  end

  def confirm
    # session[:line_item_ids] = nil
    coupon = Coupon.find_by(id: @session[:coupon_id])
    coupon.update(active: false) if coupon
    @session[:coupon_id] = nil

    @session[:current_order_complete] = true
    @order.set_total_price(@order.decorate.total_order_price)
    @order.set_completed_at
  end

  private

  def addresses_params
    @params.require(:addresses_form)
  end

  def order_params
    @params.require(:order).permit(:delivery_id)
  end

  def credit_card_params
    @params.require(:credit_card).permit(:name, :card_number, :cvv, :expiration_month_year)
  end
end
