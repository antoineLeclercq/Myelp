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
    it 'sets @business' do
      get :new
      expect(assigns[:business]).to be_new_record
    end
  end

  describe 'POST create' do
    it 'sets @business' do
      post :create, params: { business: Fabricate.attributes_for(:business) }

      expect(assigns[:business]).to be_present
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
end
