class Category < ApplicationRecord
  validates :name, presence: true
  mount_uploader :image, CategoryUploader

  acts_as_nested_set counter_cache: :children_count

  def preview_image
    return '' if image.url.nil?

    image.url(:sm)
  end
end
