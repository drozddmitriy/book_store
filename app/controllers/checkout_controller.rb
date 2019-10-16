class CheckoutController < ApplicationController
  include Wicked::Wizard
  authorize_resource class: false

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show
    
    render_wizard
  end

  def update

  end
end
