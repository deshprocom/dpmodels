class TopicLike < ApplicationRecord
  belongs_to :topic, polymorphic: true
  belongs_to :user
end
