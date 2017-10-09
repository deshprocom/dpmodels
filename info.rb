class Info < ApplicationRecord
  include Publishable
  mount_uploader :image, InfoUploader

  belongs_to :info_type
  has_one :info_en, foreign_key: 'id', dependent: :destroy
  accepts_nested_attributes_for :info_en, update_only: true

  after_initialize do
    self.date ||= Date.current
  end

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end

  after_update do
    info_en || build_info_en
    info_en.save
  end

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  scope :published, -> { where(published: true) }
  scope :topped, -> { where(top: true) }

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
