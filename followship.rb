class Followship < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'

  validate on: :create do
    errors.add(:base, '已存在') if Followship.where(follower: follower_id, following: following_id).exists?
  end

  def self.follow(user, followed_user)
    result = find_by(follower: followed_user, following: user)
    followship = create(follower: user, following: followed_user, is_following: result.present?)
    return if followship.errors.present?
    result.update!(is_following: true) if result.present?

    user.counter.increment!(:following_count)
    followed_user.counter.increment!(:follower_count)
  end

  def self.unfollow(user, followed_user)
    find_by!(follower: user, following: followed_user).destroy
    result = find_by(follower: followed_user, following: user)
    result.update!(is_following: false) if result.present?

    user.counter.decrement!(:following_count)
    followed_user.counter.decrement!(:follower_count)
  end
end
