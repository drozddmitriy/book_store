class CheckoutController < ApplicationController
  include Wicked::Wizard
  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show
    if current_order.order_items.none?
      flash[:danger] = I18n.t('controllers.checkout.cart_empty')
      return redirect_back(fallback_location: root_path)
    end

    step == :login ? login : checkout_show
    render_wizard
  end

  # rubocop:disable Metrics/AbcSize
  def update
    @checkout = CheckoutUpdateService.new(step, current_options, params, session, flash).call
    render_wizard unless CheckoutValidService.new(step, @checkout, current_order).valid?
    redirect_to next_wizard_path unless performed?
  end
  # rubocop:enable Metrics/AbcSize

  private

  def current_options
    { user: current_user, order: current_order }
  end

  def login
    return jump_to(next_step) if user_signed_in?
  end

  def checkout_show
    return jump_to(previous_step) unless CheckoutStepService.new(current_order, step, session).call

    @checkout = CheckoutShowService.new(step, current_order, current_user, session).call
  end
end
