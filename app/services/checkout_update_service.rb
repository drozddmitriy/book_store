class CheckoutUpdateService
  attr_reader :order, :session, :user, :params, :step, :flash

  def initialize(step, order, user, params, session, flash)
    @user = user
    @order = order
    @step = step
    @params = params
    @session = session
    @flash = flash
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
    @order.update(order_params)
    return @flash[:danger] = 'Please choose delivery method!' if @order.delivery_id.nil?

    @order
  end

  def payment
    @credit_card = CreditCard.new(credit_card_params)
    @credit_card.save
    @order.update(credit_card_id: @credit_card.id)
  end

  def confirm
    coupon = Coupon.find_by(id: @session[:coupon_id])
    coupon&.update(active: false)
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
