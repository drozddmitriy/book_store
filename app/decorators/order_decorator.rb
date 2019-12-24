class OrderDecorator < Draper::Decorator
  delegate_all
  delegate :capitalize, to: :status, prefix: true

  def date
    created_at.strftime('%d/%m/%y')
  end

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
    string = ''
    3.times { string << '**** ' }
    (string << credit_card.card_number.last(4)).to_s
  end

  def show_expiration_month_year
    credit_card.expiration_month_year
  end

  def date_complete
    completed_at.strftime('%B %-d, %Y')
  end
end
