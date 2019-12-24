class CheckoutShowService
  PROGRESS = 'in_progress'.freeze
  attr_reader :step, :order, :user, :session

  def initialize(step, order, user, session)
    @user = user
    @order = order
    @step = step
    @session = session
  end

  def call
    public_send(step.to_s)
  end

  def addresses
    AddressesForm.new(user, order, show_address_params)
  end

  def delivery
    Delivery.all
  end

  def payment
    order.credit_card || user.credit_card || CreditCard.new
  end

  def confirm
    order.decorate
  end

  def complete
    order.user_id(user.id)
    user.orders.find_by(status: PROGRESS).order_in_queue!
    OrderMailer.confirm_order(user).deliver_now
    session[:current_order_complete] = false
    session[:order_id] = nil
    order.decorate
  end

  private

  def show_address_params
    return { addressable_type: 'User', addressable_id: user.id } if order.addresses.empty?

    { addressable_type: 'Order', addressable_id: order.id }
  end
end
