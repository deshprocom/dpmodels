class Info < ApplicationRecord
  mount_uploader :image, InfoUploader

  belongs_to :info_type
  has_one :info_en, foreign_key: 'id', dependent: :destroy
  accepts_nested_attributes_for :info_en, allow_destroy: true

  after_initialize do
    self.date ||= Date.current
  end

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end

  after_update do
    info_en.save
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
