class AddressService
  def initialize(user)
    @user = user
  end

  def billing
    return @user.addresses.billing.first_or_initialize if @user.addresses.billing.none?

    @user.addresses.billing.first
  end

  def shipping
    return @user.addresses.shipping.first_or_initialize if @user.addresses.shipping.none?

    @user.addresses.shipping.first
  end
end
