require 'rails_helper'

RSpec.describe 'Post show', type: :feature do
  describe 'Post' do
    before(:each) do
      @user1 = User.new(name: 'Roshan', photo: 'Tom.png', bio: 'bio', post_counter: 0, email: 'a@gmail.com',
                        password: 'password')
      @user1.skip_confirmation!
      @user1.save!
      @user2 = User.new(name: 'Amy', bio: 'bio',
                        photo: 'Tom.png',
                        email: 'b@gmail.com', password: 'password')
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

      @post1 = Post.create(title: 'First Post', text: 'This is my first post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @post2 = Post.create(title: 'Second Post', text: 'This is my second post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @post3 = Post.create(title: 'Third Post', text: 'This is my third post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @post4 = Post.create(title: 'Fourth Post', text: 'This is my fourth post', comments_counter: 0, likes_counter: 0,
                           author: @user1)

      @comment1 = Comment.create(text: 'Good job!', author: User.first,
                                 post: Post.first)
      @comment2 = Comment.create(text: 'Keep it up!', author: User.first, post: Post.first)
      @comment3 = Comment.create(text: 'Congratulations!', author: User.first, post: Post.first)

      visit user_post_path(@user1, @post1)
    end

    it 'shows posts title' do
      expect(page).to have_content('First Post')
    end

    it 'shows the person who wrote the post' do
      expect(page).to have_content('Roshan')
    end

    it 'shows number of comments' do
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end

    it 'shows number of likes' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it 'can see the post\'s body.' do
      expect(page).to have_content('Good job!')
    end

    it 'can see the username of each commentor.' do
      post = Post.first
      comment = post.comments.first
      expect(page).to have_content(comment.author.name)
    end

    it 'can see the comments of each commentor.' do
      expect(page).to have_content 'Good job!'
      expect(page).to have_content 'Keep it up!'
      expect(page).to have_content 'Congratulations!'
    end
  end
end
