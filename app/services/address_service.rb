class AddressService
  attr_reader :user, :address

  def initialize(user, address)
    @user = user
    @address = address
  end

  def billing
    return address if address && address.cast == 'billing'

    user.addresses.billing.first_or_initialize
  end

  def shipping
    return address if address && address.cast == 'shipping'

    user.addresses.shipping.first_or_initialize
  end
end
