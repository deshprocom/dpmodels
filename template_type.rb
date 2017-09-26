class TemplateType < ApplicationRecord
  has_many :reply_templates, foreign_key: :type_id
  validates :name, presence: true, uniqueness: true
end
