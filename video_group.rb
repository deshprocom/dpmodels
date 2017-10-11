class VideoGroup < ApplicationRecord
  has_many :videos
  has_one :video_group_en, foreign_key: 'id', dependent: :destroy
  accepts_nested_attributes_for :video_group_en, update_only: true
end
