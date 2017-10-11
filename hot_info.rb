class HotInfo < ApplicationRecord
  belongs_to :source, polymorphic: true
  attr_accessor :source_title
  validates :source_type, presence: true
  validates :source_id, presence: true

  def source_title
    return if source.nil?

    source[:name] || source[:title]
  end

  def source_image
    return if source.nil?

    source.image_thumb
  end
end
