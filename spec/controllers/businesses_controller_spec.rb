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
end
