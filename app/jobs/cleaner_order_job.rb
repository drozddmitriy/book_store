class CleanerOrderJob < ApplicationJob
  queue_as :scheduler

  def perform(*_args)
    Order.where(user_id: nil)
         .where('created_at < ?', Time.current - 1.day).destroy_all
  end
end
