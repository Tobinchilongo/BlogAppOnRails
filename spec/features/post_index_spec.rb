require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
  describe 'Post' do
    before(:each) do
      @user1 = User.new(name: 'TTT', photo: 'R.png', bio: 'bio', post_counter: 0, email: '0@gmail.com',
                        password: 'password')
      @user1.skip_confirmation!
      @user1.save!
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

      visit(user_posts_path(@user1.id))
    end

    it "shows user's profile picture" do
      all('R.png').each do |i|
        expect(i[:src]).to eq('R.png')
      end
    end

    it 'shows the users username' do
      expect(page).to have_content('TTT')
    end

    it 'shows number of posts of user has written' do
      post = Post.all
      expect(post.size).to eql(4)
    end

    it 'shows number of posts by user' do
      user = User.first
      expect(page).to have_content(user.post_counter)
    end

    it 'shows posts title' do
      expect(page).to have_content('First Post')
    end

    it 'can see some of the post detail' do
      expect(page).to have_content 'This is my first post'
    end

    it 'can see the first comment on a post' do
      expect(page).to have_content 'Good job!'
    end

    it 'can see how many comments a post has.' do
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end

    it 'can see how many likes a post has.' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it "redirects the user to the post's show page after clickin on it" do
      click_link 'First Post'
      expect(page).to have_current_path user_post_path(@post1.author_id, @post1)
    end
  end
end
