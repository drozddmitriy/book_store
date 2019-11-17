class OrderAddressesDecorator < Draper::Decorator
  delegate_all

  def capitalize_address
    "#{cast.capitalize} Address"
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def city_zip
    "#{city} #{zip}"
  end

  def phone_address
    "Phone #{phone}"
  end
end
