class CleanerOrderJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Order.where(user_id: nil).destroy_all
  end
end
