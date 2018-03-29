class UserTopic < ApplicationRecord
  belongs_to :user
  include UserTopicCountable
  has_many :topic_images, class_name: 'UserTopicImage'
  has_one :counter, class_name: 'UserTopicCounter', dependent: :destroy

  scope :undeleted, -> { where(deleted: false) }
  scope :sorted, -> { order(created_at: :desc) }
  scope :recommended, -> { where(recommended: true) }

  def publish!
    update(published: true, published_time: Time.zone.now)
  end
end
