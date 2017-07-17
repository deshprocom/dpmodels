class InfoEn < ApplicationRecord
  # belongs_to :info
  belongs_to :info_type_en, foreign_key: 'info_type_id'
end