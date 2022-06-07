class Like < ApplicationRecord
  belongs_to :users
  belongs_to :posts

  after_save :update_counter

  def update_counter
    post.increment!(:likes_counter)
  end
end
