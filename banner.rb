class Banner < ApplicationRecord
  mount_uploader :image, BannerUploader
  attr_accessor :source_title

  validates :source_type, presence: true
  validates :source_id, presence: true, if: :internal_source?
  validates :image, presence: true

  def internal_source?
    source_type.in? %w(race info video)
  end

  def source
    @source ||= source_id && source_type.classify.safe_constantize.find(source_id)
  end

  def source_title
    return if source.nil?

    source[:name] || source[:title]
  end
end
