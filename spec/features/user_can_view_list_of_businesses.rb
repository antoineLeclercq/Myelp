require 'rails_helper'

feature 'user can view a list of businesses' do
  scenario 'user views a list of businesses' do
    business1 = Fabricate(:business)
    business2 = Fabricate(:business)
    business3 = Fabricate(:business)

    visit_home_page

    expect_list_of_businesses([business1, business2, business3])
  end

  def expect_list_of_businesses(businesses_arr)
    businesses_arr.each do |business|
      expect(page).to have_content(business.name)
      expect(page).to have_content(business.street)
    end
  end
end
