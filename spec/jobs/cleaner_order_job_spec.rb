RSpec.describe CleanerOrderJob, type: :job do
  subject(:job) { described_class.perform_later }

  it 'matches with enqueued job' do
    expect { described_class.perform_later }.to have_enqueued_job(described_class).on_queue('scheduler')
  end

  context 'when execute perform' do
    let!(:order_1) { create(:order, created_at: Time.current - 1.day + 1.second, user_id: nil) }
    let!(:order_2) { create(:order, created_at: Time.current - 1.day - 1.second) }
    let!(:expired_order_1) { create(:order, created_at: Time.current - 1.day - 1.second, user_id: nil) }
    let!(:expired_order_2) { create(:order, created_at: Time.current - 1.day, user_id: nil) }

    it 'deletes expired order' do
      perform_enqueued_jobs { job }

      expect(Order.all).to match_array([order_1, order_2])
    end
  end
end
