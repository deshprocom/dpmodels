class HotInfo < ApplicationRecord
  belongs_to :source, polymorphic: true
  attr_accessor :source_title
  validates :source_type, presence: true
  validates :source_id, presence: true
  scope :default_order, -> { order(position: :asc) }
  scope :position_desc, -> { order(position: :desc) }
  scope :info_of, -> { where(source_type: :Info) }
  scope :video_of, -> { where(source_type: :Video) }

  after_destroy do
    close_view_toggle
  end

  def source_title
    return if source.nil?

    source[:name] || source[:title]
  end

  def source_image
    return if source.nil?

    source.image_thumb
  end

  # 判断该热门对应的资源是否有开启增长
  def view_toggle?
    source.topic_view_toggle.present?
  end

  def open_view_toggle
    source.topic_view_toggle.update(toggle_status: true, hot: true)
  end

  def close_view_toggle
    source.topic_view_toggle&.update(hot: false)
  end
end
