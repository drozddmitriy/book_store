require 'rails_helper'

RSpec.describe Delivery, type: :model do
  it { expect(subject).to have_many(:orders).dependent(:destroy) }

  %i[name time price].each do |field|
    it { expect(subject).to validate_presence_of(field) }
  end

end
