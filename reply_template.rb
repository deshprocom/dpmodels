class ReplyTemplate < ApplicationRecord
  validates :source, :content, presence: true
  validates :content, uniqueness: true
  belongs_to :template_type, foreign_key: :type_id
end
