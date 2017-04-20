require 'rails_helper'

feature 'User can view other users profile' do
  given(:user) { Fabricate(:user) }
  given(:review1) { Fabricate(:review, user: user, business: Fabricate(:business)) }
  given(:review2) { Fabricate(:review, user: user, business: Fabricate(:business)) }

  background do
    review1
    review2
  end

  scenario "user views other user's profile with reviews" do
    visit user_path(user)

    expect_to_see_user_info
    expect_to_see_user_reviews_in_reverse_chronological_order([review2, review1])
  end

  def expect_to_see_user_info
    expect(page).to have_content(user.full_name)
    expect(page).to have_content(user.location)
  end

  def expect_to_see_user_reviews_in_reverse_chronological_order(reviews)
    page.all('.review').each_with_index do |review, index|
      expect(review).to have_content(reviews[index].content)
      expect(review).to have_content(reviews[index].rating)
    end
  end
end
