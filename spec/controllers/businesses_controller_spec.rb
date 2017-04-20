require 'rails_helper'

describe BusinessesController do
  describe 'GET index' do
    it 'sets @businesses sorted by created_at in reverse chronological order' do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)
      business3 = Fabricate(:business, created_at: 1.day.ago)

      get :index

      expect(assigns[:businesses]).to eq([business2, business1, business3])
    end
  end

  describe 'GET new' do
    let(:business) { Fabricate(:business) }

    context 'with authenticated users' do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }

      it 'sets @business' do
        get :new

        expect(assigns[:business]).to be_a(Business)
      end
    end

    context 'with unauthenticated users' do
      it "does'nt set @business" do
        get :new

        expect(assigns[:business]).to be_nil
      end

      it 'redirects to sign in page' do
        get :new

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'POST create' do
    context 'with authenticated users' do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }

      it 'sets @business' do
        post :create, params: { business: Fabricate.attributes_for(:business) }

        expect(assigns[:business]).to be_a(Business)
      end

      it 'saves @business' do
        business = Fabricate.build(:business)

        expect(Business).to receive(:new).and_return(business)
        expect(business).to receive(:save)

        post :create, params: { business: business.attributes }
      end

      context 'successful save' do
        it 'sets flash success message' do
          post :create, params: { business: Fabricate.attributes_for(:business) }

          expect(flash[:success]).to be_present
        end

        it 'redirects to businesses path' do
          post :create, params: { business: Fabricate.attributes_for(:business) }

          expect(response).to redirect_to(businesses_path)
        end
      end

      context 'unsuccessful save' do
        it 'renders new template' do
          post :create, params: { business: Fabricate.attributes_for(:business, name: '') }

          expect(response).to render_template(:new)
        end
      end
    end

    context 'with unauthenticated users' do
      it "does'nt set @business" do
        post :create, params: { business: Fabricate.attributes_for(:business, name: '') }

        expect(assigns[:business]).to be_nil
      end

      it 'redirects to sign in page' do
        get :new

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'GET show' do
    let(:business) { Fabricate(:business) }

    it 'sets @business' do
      get :show, params: { id: business.id }

      expect(assigns[:business]).to eq(business)
    end
  end
end
