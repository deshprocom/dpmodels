class UserTopic < ApplicationRecord
  belongs_to :user
  include TopicCountable
  has_many :topic_images, class_name: 'UserTopicImage'
  has_one :counter, class_name: 'UserTopicCounter', dependent: :destroy
  has_many :comments, as: :topic, dependent: :destroy
  has_many :topic_likes, as: :topic

  default_scope { where(deleted: false) }

  scope :undeleted, -> { where(deleted: false) }
  scope :sorted, -> { order(created_at: :desc) }
  scope :recommended, -> { where(recommended: true) }
  scope :draft, -> { where(body_type: 'long').where(published: false) }
  scope :order_show, -> { order(recommended: :desc).order(created_at: :desc) }

  alias_attribute :description, :body

  def publish!
    update(published: true, published_time: Time.zone.now)
  end

  def long?
    body_type == 'long'
  end

  def short?
    body_type == 'short'
  end

  def draft?
    !published && long?
  end

  def total_likes
    counter.likes
  end
end
