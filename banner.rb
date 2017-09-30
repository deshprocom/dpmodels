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
    @source ||= case source_type
                when 'race' then source_id && Race.find(source_id)
                when 'info' then source_id && Info.find(source_id)
                when 'video' then source_id && Video.find(source_id)
                else
                  nil
              end
  end

  def source_title
    return if source.nil?

    source[:name] || source[:title]
  end
end
