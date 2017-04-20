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

  describe 'GET new' do
    let(:business) { Fabricate(:business) }

    context 'with authenticated users' do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }

      it 'sets @business to the business to be reviewed' do
        get :new, params: { business_id: business.id }

        expect(assigns[:business]).to eq(business)
      end

      it 'sets @review to new review record' do
        get :new, params: { business_id: business.id }

        expect(assigns[:review]).to be_a(Review)
      end
    end

    context 'with unauthenticated users' do
      it "does'nt set @business or @review" do
        get :new, params: { business_id: business.id }

        expect(assigns[:business]).to be_nil
        expect(assigns[:review]).to be_nil
      end
    end
  end

  describe 'POST create' do
    let(:business) { Fabricate(:business) }

    context 'with authenticated users' do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }

      it 'sets @business' do
        post :create, params: { business_id: business.id, review: Fabricate.attributes_for(:review) }

        expect(assigns[:business]).to eq(business)
      end

      it 'sets @review with user and business' do
        post :create, params: { business_id: business.id, review: Fabricate.attributes_for(:review) }

        expect(assigns[:review]).to be_a(Review)
        expect(assigns[:review].user).to eq(user)
        expect(assigns[:review].business).to eq(business)
      end

      context 'with successful save' do
        it 'sets success message' do
          post :create, params: { business_id: business.id, review: Fabricate.attributes_for(:review) }

          expect(flash[:success]).to be_present
        end

        it 'redirects to business page' do
          post :create, params: { business_id: business.id, review: Fabricate.attributes_for(:review) }

          expect(response).to redirect_to(business_path(business))
        end
      end

      context 'with unsuccessful save' do
        it 'renders new template' do
          post :create, params: { business_id: business.id, review: Fabricate.attributes_for(:review, rating: 2.4) }

          expect(response).to render_template(:new)
        end
      end
    end

    context 'with unauthenticated users' do
      it "doesn't set @review or @business" do
        post :create, params: { business_id: business.id, review: Fabricate.attributes_for(:review) }

        expect(assigns[:review]).to be_nil
        expect(assigns[:business]).to be_nil        
      end

      it 'redirects to sign in page' do
        post :create, params: { business_id: business.id, review: Fabricate.attributes_for(:review) }

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
