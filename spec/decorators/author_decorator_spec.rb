RSpec.describe AuthorDecorator do
  subject(:decorator) { described_class.new(author) }

  let(:author) { create(:author) }
  let(:full_name) { "#{author.first_name} #{author.last_name}" }

  describe '#full_name' do
    it { expect(decorator.full_name).to eq(full_name) }
  end
end
