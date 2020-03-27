RSpec.configure do |config|
  config.after(:each, type: :job) do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
