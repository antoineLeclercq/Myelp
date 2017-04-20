def visit_home_page
  visit root_path
end

def sign_in
  visit sign_in_path

  within 'form' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end
end