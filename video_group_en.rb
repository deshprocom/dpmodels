class VideoGroupEn < ApplicationRecord
  has_many :video_ens
  belongs_to :video_group, foreign_key: 'id'
end
