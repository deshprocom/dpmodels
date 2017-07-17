class InfoTypeEn < ApplicationRecord
  # belongs_to :info_type
  has_many :info_ens, foreign_key: 'info_type_id', dependent: :destroy
end