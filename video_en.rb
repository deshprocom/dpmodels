class VideoEn < ApplicationRecord
  belongs_to :video_type_en, foreign_key: 'video_type_id'
  belongs_to :video, foreign_key: 'id'

  before_save do
    diff_attrs = %w(name description)
    assign_attributes video.reload.attributes.reject { |k| attributes[k].present? && k.in?(diff_attrs) }
  end
end
