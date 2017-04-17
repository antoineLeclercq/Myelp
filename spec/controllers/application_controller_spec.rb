require 'rails_helper'

describe ApplicationController do
  let(:user) { Fabricate(:user) }

  describe '#current_user' do
    it 'returns user in session' do
      session[:user_id] = user.id

      expect(controller.current_user).to eq(user)
    end

    it 'returns nil if there is no user in session' do
      expect(controller.current_user).to be_nil
    end

    it 'sets @current_user with user in session for memoization' do
      session[:user_id] = user.id
      controller.current_user

      expect(assigns[:current_user]).to be_present
    end

    it 'is also a helper method' do

    end
  end

  describe '#logged_in?' do
    it 'returns true if there is a current user' do
      session[:user_id] = user.id

      expect(controller.logged_in?).to eq(true)
    end

    it "returns false if there isn't a current user" do
      expect(controller.logged_in?).to eq(false)
    end
  end
end
