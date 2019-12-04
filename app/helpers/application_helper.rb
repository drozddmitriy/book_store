module ApplicationHelper
  include Pagy::Frontend

  def alert_class(key)
    case key
    when 'notice' then 'success'
    when 'alert' then 'danger'
    else key
    end
  end

  def cart_items_count
    current_order.line_items.count
  end
end
