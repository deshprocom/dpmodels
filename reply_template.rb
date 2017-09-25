class ReplyTemplate < ApplicationRecord
  validates :content, presence: true, uniqueness: true
  belongs_to :template_type, foreign_key: :type_id

  def temp_name
    template_type&.name
  end
end
