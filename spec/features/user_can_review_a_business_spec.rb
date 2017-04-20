require 'rails_helper'

feature 'User can review a business' do
  given(:business) { Fabricate(:business) }
  given(:user) { Fabricate(:user) }

  scenario 'signed in user reviews a business with correct information' do
    sign_in

    visit business_path(business)

    write_a_review(business, 'Great place')

    expect_review_to_be_displayed

    write_a_review(business, 'Awesome place')

    expect_list_of_reviews_to_be_displayed_in_reverse_chronological_order([Review.last, Review.first])
  end

  scenario 'signed in user reviews a business with invalid information' do
    sign_in

    visit business_path(business)

    write_review_with_invalid_info

    expect_error_to_be_displayed
  end

  def write_a_review(business, content)
    click_on 'Write a Review'
    within '#new_review' do
      select '4 Stars', from: 'Rating'
      fill_in 'Review', with: content
      click_button 'Submit Review'
    end
  end

  def expect_review_to_be_displayed
    expect(page).to have_content('4/5')
    expect(page).to have_content(user.full_name)
    expect(page).to have_content('Great place')
  end

  def expect_list_of_reviews_to_be_displayed_in_reverse_chronological_order(reviews)
    page.all(:css, '.review').each_with_index do |elem, index|
      expect(elem.text).to have_content(reviews[index].content)
      expect(elem.text).to have_content(reviews[index].rating)
    end
  end

  def write_review_with_invalid_info
    click_on 'Write a Review'
    within '#new_review' do
      select '4 Stars', from: 'Rating'
      click_button 'Submit Review'
    end
  end

  def expect_error_to_be_displayed
    expect(page).to have_content("errors")
    expect(page).to have_content("Content can't be blank")
  end
end
