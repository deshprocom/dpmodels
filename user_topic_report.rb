class UserTopicReport < ApplicationRecord
  belongs_to :user_topic, optional: true
  after_create do
    user_topic.increase_reports
  end

  after_destroy do
    user_topic.decrease_reports if user_topic.counter.present?
  end
end