class AddressesForm
  include ActiveModel::Model

  attr_reader :user, :order, :billing, :shipping, :params, :use_billing

  def initialize(user, order, addresses_params = nil)
    @user = user
    @order = order
    @params = addresses_params
    @billing = billing
    @shipping = shipping
  end

  def save
    save_billing & save_shipping
  end

  def billing
    return user.addresses.billing.first_or_initialize if order.addresses.billing.none?

    order.addresses.billing.first_or_initialize
  end

  def shipping
    return user.addresses.shipping.first_or_initialize if order.addresses.shipping.none?

    order.addresses.shipping.first_or_initialize
  end

  private

  def save_billing
    @billing = order.addresses.billing.first_or_initialize
    @billing.update(address_params(:billing))
  end

  def save_shipping
    @shipping = order.addresses.shipping.first_or_initialize
    @shipping.update(set_address_cast(address_params(type)))
  end

  def address_params(type)
    params.require(type).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end

  def set_address_cast(params)
    params[:cast] = 'shipping' if params[:use_billing]

    params
  end

  def type
    params[:use_billing] ? :billing : :shipping
  end
end
