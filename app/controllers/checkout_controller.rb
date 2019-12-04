class CheckoutController < ApplicationController
  include Wicked::Wizard
  authorize_resource class: false

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show
    if current_order.line_items.none? && step == :addresses
      flash[:danger] = I18n.t('controllers.checkout.cart_empty')
      return redirect_back(fallback_location: root_path)
    end

    step == :login ? login : checkout_show
    render_wizard
  end

  def update
    @checkout = CheckoutUpdateService.new(step, current_order, current_user, params, session, flash).call
    render_wizard unless @checkout
    redirect_to next_wizard_path unless performed?
  end

  private

  def login
    return jump_to(next_step) if user_signed_in?
    # render_wizard
  end

  def checkout_show
    return jump_to(previous_step) unless CheckoutStepService.new(current_order, step, session).call

    @checkout = CheckoutShowService.new(step, current_order, current_user, session).call
  end
end
