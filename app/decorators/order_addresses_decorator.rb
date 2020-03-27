class OrderAddressesDecorator < Draper::Decorator
  delegate_all

  def capitalize_address
    I18n.t('decorator.capitalize_address', capitalize: cast.capitalize)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def city_zip
    "#{city} #{zip}"
  end

  def phone_address
    I18n.t('decorator.phone_address', phone: phone)
  end
end
