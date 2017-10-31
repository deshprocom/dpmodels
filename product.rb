class Product < ApplicationRecord
  belongs_to :category
  mount_uploader :icon, ProductUploader
  validates :title, presence: true
  validates :icon, presence: true

  def self.in_category(category)
    where(category_id: category.self_and_descendants.pluck(:id))
  end

  def preview_icon
    return '' if icon.url.nil?

    icon.url(:sm)
  end
end
