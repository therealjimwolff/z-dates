class Friendship < ApplicationRecord
  after_destroy :delete_inverse_friendship

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  validate :not_self

  private

  def create_inverse_friendship
    friend.friendships.create(friend: user)
  end

  def delete_inverse_friendship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end
end
