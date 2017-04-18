require 'rails_helper'

feature 'User can view a list of recent reviews' do
  scenario 'user views a list of recent reviews for all businesses' do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    business1 = Fabricate(:business)
    business2 = Fabricate(:business)
    review1 = Fabricate(:review, business: business1, user: user1)
    review2 = Fabricate(:review, business: business2, user: user1)
    review3 = Fabricate(:review, business: business1, user: user2)
    review4 = Fabricate(:review, business: business2, user: user2)

    visit recent_reviews_path

    expect_list_of_reviews([review4, review3, review2, review1])
  end

  def expect_list_of_reviews(reviews)
    page.all(:css, '.review').each_with_index do |elem, index|
      expect(elem.text).to have_content(reviews[index].content)
      expect(elem.text).to have_content(reviews[index].rating)
    end
  end
end
