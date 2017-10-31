class Product < ApplicationRecord
  belongs_to :category
  mount_uploader :icon, ProductUploader
  validates :title, presence: true
  validates :icon, presence: true

  def preview_icon
    return '' if icon.url.nil?

    icon.url(:sm)
  end
end
