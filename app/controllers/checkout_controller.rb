class CheckoutController < ApplicationController
  include Wicked::Wizard
  authorize_resource class: false

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show

    case step
    when :login then show_login
    when :addresses then show_addresses
    when :delivery then show_delivery
    when :payment then show_payment
    when :confirm then show_confirm
    when :complete then show_complete
    end

    render_wizard
  end

  def update

    case step
    when :addresses then update_addresses
    when :delivery then update_delivery
    when :payment then update_payment
    when :confirm then update_confirm
    when :complete then update_complete
    end

    redirect_to next_wizard_path unless performed?
  end

  def show_login
    return jump_to(next_step) if user_signed_in?
  end

  def show_addresses
    @addresses = AddressesForm.new(current_user, current_order, show_address_params)
  end

  def update_addresses
    current_order.set_order_use_billing(addresses_params[:use_billing])

    @addresses = AddressesForm.new(current_user, current_order, addresses_params)
    render_wizard unless @addresses.save
  end

  def show_delivery
    return jump_to(previous_step) unless current_order.addresses.presence

    @deliveries = Delivery.all
  end

  def show_payment
    return jump_to(previous_step) unless current_order.delivery

    @credit_card = current_order.credit_card || current_user.credit_card || CreditCard.new
  end

  def show_confirm
    return jump_to(previous_step) unless current_order.credit_card
  end

  def update_confirm
    session[:current_order_complete] = true
    current_order.set_total_price
    current_order.set_completed_at

    # session[:line_item_ids] = nil
    coupon = Coupon.find_by(id: session[:coupon_id])
    coupon.update(active: false) if coupon
    session[:coupon_id] = nil
  end

  def update_complete
  end

  def show_complete
    return jump_to(previous_step) unless session[:current_order_complete]

    binding.pry
    @order = current_order
    current_order.set_user_id(current_user.id)
    current_user.orders.last.place_in_queue!
    binding.pry
    # OrderMailer.confirm_order(current_user).deliver_now
    session[:current_order_complete] = false
    session[:order_id] = nil
  end

  def update_delivery
    current_order.update_attributes(order_params)
    flash[:danger] = 'Please choose delivery method!' if current_order.delivery_id.nil?
  end

  def update_payment
    @credit_card = CreditCard.new(credit_card_params)
    render_wizard unless @credit_card.save
    current_order.update_attributes(credit_card_id: @credit_card.id)
  end

  private

  def order_params
    params.require(:order).permit(:delivery_id)
  end

  def show_address_params
    return { addressable_type: "User", addressable_id: current_user.id } if current_order.addresses.empty?

    { addressable_type: "Order", addressable_id: current_order.id }
  end

  def addresses_params
    params.require(:addresses_form)
  end

  def credit_card_params
    params.require(:credit_card).permit(:name, :card_number, :cvv, :expiration_month_year)
  end

end
