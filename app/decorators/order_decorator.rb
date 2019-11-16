class OrderDecorator < Draper::Decorator
  delegate_all

  def date
    created_at.strftime("%d/%m/%y")
  end

  def status_capitalize
    status.capitalize
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

end
