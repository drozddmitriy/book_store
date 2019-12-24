class AddressesForm
  SHIPPING = 'shipping'.freeze
  include ActiveModel::Model

  attr_reader :user, :order, :billing, :shipping, :params, :use_billing

  def initialize(user, order, addresses_params = nil)
    @user = user
    @order = order
    @params = addresses_params
    @billing = select_address(:billing)
    @shipping = select_address(:shipping)
  end

  def save
    save_billing & save_shipping
  end

  def select_address(cast)
    return user.addresses.public_send(cast).first_or_initialize if order.addresses.public_send(cast)

    order.addresses.public_send(cast).first_or_initialize
  end

  private

  def save_billing
    @billing = order.addresses.billing.first_or_initialize
    @billing.update(address_params(:billing))
  end

  def save_shipping
    @shipping = order.addresses.shipping.first_or_initialize
    @shipping.update(address_cast(address_params(type)))
  end

  def address_params(type)
    params.require(type).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :cast)
  end

  def address_cast(params)
    params[:cast] = SHIPPING if params[:use_billing]

    params
  end

  def type
    params[:use_billing] ? :billing : :shipping
  end
end
