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
    return current_user.orders.public_send(params.to_sym) if !params.nil? && FILTERS.include?(params.to_sym)

    current_user.orders.all_orders
  end
end
