class CheckoutShowService
  def initialize(step, order, user, session)
    @user = user
    @order = order
    @step = step
    @session = session
  end

  def call
    public_send(@step.to_s)
  end

  def addresses
    AddressesForm.new(@user, @order, show_address_params)
  end

  def delivery
    Delivery.all
  end

  def payment
    @order.credit_card || @user.credit_card || CreditCard.new
  end

  def confirm
    @order.decorate
  end

  def complete
    @order.set_user_id(@user.id)
    @user.orders.last.order_in_queue!
    # OrderMailer.confirm_order(current_user).deliver_now
    @session[:current_order_complete] = false
    @session[:order_id] = nil
    @order.decorate
  end

  private

  def show_address_params
    return { addressable_type: "User", addressable_id: @user.id } if @order.addresses.empty?

    { addressable_type: "Order", addressable_id: @order.id }
  end
end
