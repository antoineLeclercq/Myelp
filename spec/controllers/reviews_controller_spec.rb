require 'rails_helper'

describe ReviewsController do
  describe 'GET recent' do
    context 'with 0 reviews' do
      it 'sets @reviews to empty array' do
        get :recent

        expect(assigns[:reviews]).to eq([])
      end
    end

    context 'with 1 review' do
      it 'sets @reviews to the most recent review' do
        review = Fabricate(:review, user: Fabricate(:user), business: Fabricate(:business))
        get :recent

        expect(assigns[:reviews]).to eq([review])
      end
    end

    context 'with 10 reviews' do
      it 'sets @reviews to the 10 most recent reviews in reverse chronological order' do
        reviews = []
        10.times do
          reviews << Fabricate(:review, user: Fabricate(:user), business: Fabricate(:business))
        end

        get :recent

        expect(assigns[:reviews]).to eq(reviews.reverse)
      end
    end

    context 'with more than 10 reviews' do
      it 'sets @reviews to 10 most recent reviews in reverse chronological order' do
        reviews = []
        20.times do
          reviews << Fabricate(:review, user: Fabricate(:user), business: Fabricate(:business))
        end

        get :recent

        expect(assigns[:reviews]).to eq(reviews.reverse[0..9])
      end
    end
  end
end
