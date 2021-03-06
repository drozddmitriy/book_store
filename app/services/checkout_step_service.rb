class CheckoutStepService
  attr_reader :step, :order, :session

  def initialize(current_order, step, session)
    @order = current_order
    @step = step
    @session = session
  end

  def call
    case step
    when :addresses then true
    when :delivery  then order.addresses.presence
    when :payment   then order.delivery
    when :confirm   then order.credit_card
    when :complete  then session[:current_order_complete]
    end
  end
end
