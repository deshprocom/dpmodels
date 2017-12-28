class TopicViewToggle < ApplicationRecord
  belongs_to :topic, polymorphic: true
end
