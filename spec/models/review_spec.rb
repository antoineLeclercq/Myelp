require 'rails_helper'

describe Review do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :business }
  it { is_expected.to validate_presence_of :rating }
  it do
    is_expected.to validate_numericality_of(:rating)
      .only_integer
      .is_greater_than_or_equal_to(0)
      .is_less_than_or_equal_to(5)
  end
  it { is_expected.to validate_presence_of :content }

  let(:user) { Fabricate(:user) }
  let(:review) { Fabricate(:review, user: user, business: Fabricate(:business)) }

  describe '#user_full_name' do
    it { expect(review.user_full_name).to eq(user.full_name) }
  end

  describe '#user_location' do
    it { expect(review.user_location).to eq(user.location) }
  end

  describe '#user_reviews_count' do
    before do
      Fabricate(:review, user: user, business: Fabricate(:business))
      Fabricate(:review, user: user, business: Fabricate(:business))
      Fabricate(:review, user: user, business: Fabricate(:business))
    end

    it { expect(review.user_reviews_count).to eq(4) }
  end
end
