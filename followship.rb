class Followship < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'

  validate :check_uniq
  def check_uniq
    errors.add(:base, '已存在') if Followship.where(follower: follower_id, following: following_id).exists?
  end

  after_create do
    UserCounter.find_by!(user_id: follower_id).increment!(:following_count)
    UserCounter.find_by!(user_id: following_id).increment!(:follower_count)
  end

  before_destroy do
    UserCounter.find_by!(user_id: follower_id).decrement!(:following_count)
    UserCounter.find_by!(user_id: following_id).decrement!(:follower_count)
  end
end
