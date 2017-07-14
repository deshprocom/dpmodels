class Info < ApplicationRecord
  mount_uploader :image, InfoUploader
  # has_one :info_en, dependent: :destroy
  # accepts_nested_attributes_for :info_en, allow_destroy: true
  belongs_to :info_type

  after_initialize do
    self.date ||= Date.current
  end

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
    return '' if image.url.nil?

    image.url(:preview)
  end

  def big_image
    return '' if image.url.nil?

    image.url
  end
end
