class VideoEn < ApplicationRecord
  belongs_to :video_type_en, foreign_key: 'video_type_id'
  belongs_to :video, foreign_key: 'id'
  has_many :race_tag_maps, as: :data

  before_save do
    diff_attrs = %w(name description title_desc)
    assign_attributes video.reload.attributes.reject { |k| attributes[k].present? && k.in?(diff_attrs) }
    self.description = ActionController::Base.helpers.strip_tags(description)
  end
end
