require 'rails_helper'

describe SessionsController do
  let(:user) { Fabricate(:user) }

  describe 'POST create' do
    it 'finds user by email' do
      expect(User).to receive(:find_by).with(email: user.email).and_return(user)

      post :create, params: { email: user.email, password: user.password }
    end

    it 'authenticates user with password' do
      expect(User).to receive(:find_by).and_return(user)
      expect(user).to receive(:authenticate).with(user.password).and_return(true)

      post :create, params: { email: user.email, password: user.password }
    end

    context 'valid credentials' do
      it 'puts user in the session' do
        post :create, params: { email: user.email, password: user.password }

        expect(session[:user_id]).to eq(user.id)
      end

      it 'sets a success message' do
        post :create, params: { email: user.email, password: user.password }

        expect(flash[:success]).to be_present
      end

      it 'redirects user to root path' do
        post :create, params: { email: user.email, password: user.password }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'invalid credentials' do
      it 'sets unspecific error message' do
        post :create, params: { email: user.email, password: 'invalid password' }

        expect(flash[:error]).to be_present
      end

      it 'redirects sign in path' do
        post :create, params: { email: user.email, password: 'invalid password' }

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      session[:user_id] = user.id
      delete :destroy
    end

    it 'removes user from session' do
      expect(session[:user_id]).to be_nil
    end

    it 'sets notice message' do
      expect(flash[:notice]).to be_present
    end

    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end
  end
end
