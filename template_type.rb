class TemplateType < ApplicationRecord
  has_many :reply_templates, foreign_key: :type_id
end
