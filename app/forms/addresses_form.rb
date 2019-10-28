class AddressesForm
  include ActiveModel::Model

  def initialize(user, order, addresses_params = nil)
    @user = user
    @order = order
    @params = addresses_params
    @billing = set_billing
    @shipping = set_shipping
  end

  def save
    save_billing & save_shipping
  end

  def billing
    set_billing
  end

  def shipping
    set_shipping
  end

  private

  def save_billing
    @billing = @order.addresses.billing.first_or_initialize
    @billing.update(address_params(:billing))
  end

  def save_shipping
    @shipping = @order.addresses.shipping.first_or_initialize
    @shipping.update(address_params(:shipping))
  end

  def set_billing
    return @user.addresses.billing.first_or_initialize if @order.addresses.billing.none?

    @order.addresses.billing.first_or_initialize
  end

  def set_shipping
    return @user.addresses.shipping.first_or_initialize if @order.addresses.shipping.none?

    @order.addresses.shipping.first_or_initialize
  end

  def address_params(type)
    @params.require(type).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end
end
