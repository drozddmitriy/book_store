class OrderDecorator < Draper::Decorator
  delegate_all

  def date
    created_at.strftime('%d/%m/%y')
  end

  delegate :capitalize, to: :status, prefix: true

  def total_price
    line_items.map { |item| item.book.price * item.quantity }.sum
  end

  def discount
    return 0 unless coupon

    total_price * coupon.sale / 100
  end

  def total_order_price
    return total_price unless coupon

    total_price - discount
  end

  def show_credit_card
    "**** **** **** #{credit_card.card_number.last(4)}"
  end

  def show_expiration_month_year
    credit_card.expiration_month_year
  end

  def date_complete
    completed_at.strftime('%B %-d, %Y')
  end

  def full_name_complete
    "#{addresses.first.firstname} #{addresses.first.lastname}"
  end

  def address_complete
    addresses.first.address
  end

  def city_zip_complete
    "#{addresses.first.city} #{addresses.first.zip}"
  end

  def country_complete
    addresses.first.country
  end

  def phone_complete
    "Phone #{addresses.first.phone}"
  end
end
