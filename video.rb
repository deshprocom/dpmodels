class Video < ApplicationRecord
  mount_uploader :cover_link, VideoCoverUploader
  belongs_to :video_type

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
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
