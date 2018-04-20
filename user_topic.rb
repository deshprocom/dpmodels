class UserTopic < ApplicationRecord
  belongs_to :user
  include TopicCountable
  has_many :topic_images, class_name: 'UserTopicImage'
  has_many :reports, class_name: 'UserTopicReport', dependent: :destroy
  has_many :comments, as: :topic, dependent: :destroy
  has_one :counter, class_name: 'UserTopicCounter', dependent: :destroy
  has_many :topic_likes, as: :topic, dependent: :destroy
  # alias_attribute :location, :address

  default_scope { where(deleted: false) }

  scope :undeleted, -> { where(deleted: false) }
  scope :sorted, -> { order(created_at: :desc) }
  scope :recommended, -> { where(recommended: true) }
  scope :order_show, -> { order(recommended: :desc).order(created_at: :desc) }

  alias_attribute :description, :body

  after_destroy do
    user.decrease_long_topics if long?
    user.decrease_short_topics if short?
  end

  def long?
    body_type == 'long'
  end

  def short?
    body_type == 'short'
  end

  def total_likes
    counter.likes
  end
end
