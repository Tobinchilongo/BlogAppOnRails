class Post < ApplicationRecord
  after_save :increment_posts_counter

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def recent_comments
    Comment.order(created_at: :desc).limit(5)
  end
end
