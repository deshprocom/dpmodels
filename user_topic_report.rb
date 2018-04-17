class UserTopicReport < ApplicationRecord
  belongs_to :user_topic, optional: true
  belongs_to :user, optional: true
end