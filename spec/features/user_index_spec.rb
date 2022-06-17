require 'rails_helper'

RSpec.describe 'users#index', type: :feature do
  describe 'User' do
    before(:each) do
      @user1 = User.new(name: 'Amy', photo: 'R.png', bio: 'bio', post_counter: 0, email: 'amy@gmail.com',
                        password: 'password')
      @user1.skip_confirmation!
      @user1.save!
      @user2 = User.new(name: 'Amy', bio: 'bio',
                        photo: 'Tom.png',
                        email: 'bany@gmail.com', password: 'password')
      @user2.skip_confirmation!
      @user2.save!
      @user3 = User.new(name: 'Jerry', bio: 'bio',
                        photo: 'Tom.png',
                        email: 'jerry@gmail.com', password: 'password')
      @user3.skip_confirmation!
      @user3.save!
      visit root_path
      fill_in 'Email', with: 'amy@gmail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end

    it 'Shows the username' do
      expect(page).to have_content('Amy')
    end

    it "Shows the user's photo" do
      all('R.png').each do |i|
        expect(i[:src]).to eq('R.png')
      end
    end

    it 'Shows the number of posts' do
      all(:css, '.num_post').each do |post|
        expect(post).to have_content('Number of posts: 0')
      end
    end

    it "after clicking on the user, it will be redirected to that user's show page" do
      expect(page).to have_content('Number of posts: 0')
      expect(page).to have_content 'Amy'
      expect(page).to have_no_content('jerry')
    end
  end
end
