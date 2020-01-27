class CheckoutValidService
  attr_reader :step, :checkout, :order

  def initialize(step, checkout, order)
    @step = step
    @checkout = checkout
    @order = order
  end

  def valid?
    case step
    when :addresses then @checkout.billing.errors.full_messages.empty? && @checkout.shipping.errors.full_messages.empty?
    when :delivery  then @checkout
    when :payment   then order.credit_card_id
    when :confirm   then order.completed_at
    end
  end
end
