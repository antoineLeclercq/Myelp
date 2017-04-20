require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets @user' do
      get :new

      expect(assigns[:user]).to be_a(User)
    end
  end

  describe 'POST create' do
    it 'sets @user' do
      post :create, params: { user: Fabricate.attributes_for(:user) }

      expect(assigns[:user]).to be_a(User)
    end

    it 'saves new user' do
      user = Fabricate.build(:user)

      expect(User).to receive(:new).and_return(user)
      expect(user).to receive(:save)

      post :create, params: { user: user.attributes }
    end

    context 'successful save' do
      it 'sets success message' do
        post :create, params: { user: Fabricate.attributes_for(:user) }

        expect(flash[:success]).to be_present
      end

      it 'redirects to login page' do
        post :create, params: { user: Fabricate.attributes_for(:user) }

        expect(response).to redirect_to sign_in_path
      end
    end

    context 'unsuccessful save' do
      it 'renders the new template' do
        post :create, params: { user: Fabricate.attributes_for(:user, email: '') }

        expect(response).to render_template :new
      end
    end
  end
end
