class UserTopic < ApplicationRecord
  belongs_to :user
  include UserTopicCountable
  has_many :topic_images, class_name: 'UserTopicImage'
  has_one :counter, class_name: 'UserTopicCounter'

  def publish!
    update(published: true, published_time: Time.zone.now)
  end
end
