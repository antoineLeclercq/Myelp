require 'rails_helper'

describe Business do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :street }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_presence_of :zipcode }
  it { is_expected.to validate_numericality_of :zipcode }
  it { is_expected.to validate_presence_of :phone }
  it { is_expected.to validate_numericality_of :phone }
  it { is_expected.to have_many(:reviews).order(created_at: :desc) }

  describe '#average_rating' do
    let(:business) { Fabricate(:business) }

    before do
      Fabricate(:review, rating: 5, user: Fabricate(:user), business: business)
      Fabricate(:review, rating: 3, user: Fabricate(:user), business: business)
      Fabricate(:review, rating: 4, user: Fabricate(:user), business: business)
      Fabricate(:review, rating: 3, user: Fabricate(:user), business: business)
    end

    it { expect(business.average_rating).to eq(3.8) }
  end
end
