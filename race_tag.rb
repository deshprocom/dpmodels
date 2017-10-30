class RaceTag < ApplicationRecord
  has_many :race_tag_maps
  has_one  :race_tag_en, foreign_key: 'id', dependent: :destroy
  accepts_nested_attributes_for :race_tag_en, update_only: true
  after_update { race_tag_en&.save }
end
