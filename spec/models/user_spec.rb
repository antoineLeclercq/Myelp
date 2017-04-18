require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of :full_name }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to have_secure_password }
  it { is_expected.to have_many :reviews }

  let(:user) { Fabricate(:user, city: 'New York', state: 'NY') }

  describe '#location' do
    it { expect(user.location).to eq('New York, NY') }
  end

  describe '#reviews_count' do
    before do
      Fabricate(:review, user: user, business: Fabricate(:business))
      Fabricate(:review, user: user, business: Fabricate(:business))
      Fabricate(:review, user: user, business: Fabricate(:business))
    end

    it { expect(user.reviews_count).to eq(3) }
  end
end
