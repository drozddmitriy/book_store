class CleanerOrderJob < ApplicationJob
  def perform(*_args)
    Order.where(user_id: nil)
         .where("now() >= created_at + INTERVAL '24 hours'").destroy_all
  end
end
