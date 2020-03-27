RSpec.describe OrderMailer, type: :mailer do
  context 'when send email' do
    let(:user) { create(:user) }
    let(:mail) { described_class.confirm_order(user) }

    it { expect(mail.subject).to eq(I18n.t('order_mailer.message')) }
    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq(['from@example.com']) }
    it { expect(mail.body.encoded).to match(I18n.t('order_mailer.hi', email: user.email)) }
  end
end
