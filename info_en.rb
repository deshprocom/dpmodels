class InfoEn < ApplicationRecord
  belongs_to :info_type_en, foreign_key: 'info_type_id'
  belongs_to :info, foreign_key: 'id'

  before_save do
    diff_attrs = %w(title source description)
    assign_attributes info.reload.attributes.reject { |k| attributes[k].present? && k.in?(diff_attrs) }
  end
end