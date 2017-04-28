class Photo < ApplicationRecord
  belongs_to :user, polymorphic: true

  validates :image, presence: true
  mount_uploader :image, PhotoUploader

  def real_url
    return '' if image.url.nil?

    ENV['CMS_PHOTO_PATH'] + image.url
  end
end
