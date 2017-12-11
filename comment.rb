class Comment < ApplicationRecord
  belongs_to :topic, polymorphic: true
  has_many :replies, dependent: :destroy
  belongs_to :user
end
