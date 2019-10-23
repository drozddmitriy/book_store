class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
  end

  def after_sign_in_path_for(resource)
    if current_order.line_items.any?
      checkout_path(:addresses)
    else
      super
    end
  end

  def after_sign_out_path_for(resource)
    current_order.destroy
    super
  end
end
