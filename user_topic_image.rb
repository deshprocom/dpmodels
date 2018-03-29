class UserTopicImage < ApplicationRecord
  mount_uploader :image, PhotoUploader
  belongs_to :user_topic

  def image_path
    return '' if image.url.nil?

    image.url
  end
end