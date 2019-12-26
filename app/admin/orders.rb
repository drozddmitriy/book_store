ActiveAdmin.register Order do
  preserve_default_filters!
  remove_filter :order_items, :coupon, :addresses
  filter :user, as: :select, collection: -> { User.all.map(&:email) }
  permit_params :active_admin_requested_event, :number,
                :total_price, :status, :user_id, :credit_card_id,
                :credit_card_id, :delivery_id, :use_billing, :completed_at

  scope :all_orders
  scope :in_progress
  scope :in_queue
  scope :in_delivery
  scope :delivered
  scope :canceled

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    if event.present?
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      order.send("#{safe_event}!")
    end
  end

  form do |f|
    f.inputs do
      f.input :status, input_html: { disabled: true }, label: I18n.t('views.admin.current_state')
    end

    f.inputs do
      f.input :active_admin_requested_event,
              label: I18n.t('views.admin.change_state'), as: :select,
              collection: f.object.aasm.events(permitted: true).map(&:name)
    end

    f.actions
  end
end
