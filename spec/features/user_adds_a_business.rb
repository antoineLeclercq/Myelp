require 'rails_helper'

feature 'user can add a business' do
  scenario 'user adds a business with correct information' do
    visit new_business_path

    create_business

    expect_business_to_be_displayed
  end

  scenario 'user adds a busines with invalid information' do
    visit new_business_path

    create_business_with_invalid_info

    expect_error_to_be_displayed
  end

  def create_business
    fill_in 'Name', with: 'Chipotle'
    fill_in 'Street', with: '1 West Street'
    fill_in 'City', with: 'New York'
    fill_in 'State', with: 'NY'
    fill_in 'Zipcode', with: '10000'
    fill_in 'Area', with: 'Midtown'
    click_button 'Create Business'
  end

  def expect_business_to_be_displayed
    expect(page).to have_content('Chipotle')
    expect(page).to have_content('1 West Street')
  end

  def create_business_with_invalid_info
    fill_in 'Name', with: ''
    fill_in 'Street', with: '1 West Street'
    fill_in 'City', with: 'New York'
    fill_in 'State', with: 'NY'
    fill_in 'Zipcode', with: '10000'
    fill_in 'Area', with: 'Midtown'
    click_button 'Create Business'
  end

  def expect_error_to_be_displayed
    expect(page).to have_content("errors")
    expect(page).to have_content("Name can't be blank")
  end
end
