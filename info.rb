class Info < ApplicationRecord
  mount_uploader :image, InfoUploader

  belongs_to :info_type
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
    return '' if image.url.nil?

    ENV['CMS_PHOTO_PATH'] + image.url(:preview)
  end
end
