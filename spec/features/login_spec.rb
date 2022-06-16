require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  before(:each) do
    @user = create(:user)
  end

  it 'should login with valid credentials' do
    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end

  it 'I can logout' do
    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    click_link 'Logout'
    expect(page).to have_content('Signed out successfully.')
  end

  it 'should not login with blank credentials' do
    visit login_path
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
