require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  context 'when send email' do
    let(:user) { create(:user) }
    let(:mail) { described_class.confirm_order(user) }

    it { expect(mail.subject).to eq('Your Order with bookstore.com') }
    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq(['from@example.com']) }
    it { expect(mail.body.encoded).to match("Hi #{user.email}!") }
  end
end
