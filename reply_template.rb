class ReplyTemplate < ApplicationRecord
  validates :source, :content, presence: true
  validates :content, uniqueness: true
end
