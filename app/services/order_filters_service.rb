class OrderFiltersService
  FILTERS = {
    in_queue: I18n.t('controllers.orders.processing'),
    in_delivery: I18n.t('controllers.orders.in_delivery'),
    delivered: I18n.t('controllers.orders.delivered'),
    canceled: I18n.t('controllers.orders.canceled'),
    all: I18n.t('controllers.orders.all')
  }.freeze

  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def filter
    case params
    when I18n.t('controllers.orders_filter.in_queue') then current_user.orders.in_queue
    when I18n.t('controllers.orders_filter.in_delivery') then current_user.orders.in_delivery
    when I18n.t('controllers.orders_filter.delivered') then current_user.orders.delivered
    when I18n.t('controllers.orders_filter.canceled') then current_user.orders.canceled
    else current_user.orders.all_orders
    end
  end
end
