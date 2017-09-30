class Video < ApplicationRecord
  mount_uploader :cover_link, VideoCoverUploader
  belongs_to :video_type
  has_one :video_en, foreign_key: 'id', dependent: :destroy
  belongs_to :video_group, optional: true
  accepts_nested_attributes_for :video_en, update_only: true

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end

  after_update do
    video_en || build_video_en
    video_en.save
  end

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  scope :published, -> { where(published: true) }
  scope :topped, -> { where(top: true) }

  def publish!
    update(published: true)
  end

  def unpublish!
    update(published: false)
  end

  def top!
    update(top: true)
  end

  def untop!
    update(top: false)
  end

  def image_thumb
    return '' if cover_link.url.nil?

    cover_link.url(:preview)
  end

  def big_image
    return '' if cover_link.url.nil?

    cover_link.url
  end
end
