class VideoType < ApplicationRecord
  include Publishable

  has_many :videos, dependent: :destroy
  has_one  :video_type_en, foreign_key: 'id', dependent: :destroy
  accepts_nested_attributes_for :video_type_en, update_only: true

  after_update do
    video_type_en || build_video_type_en
    video_type_en.save
  end

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  def self.video_type_array
    all.collect do |item|
      type_name = item.published ? item.name + ' [已发布]' : item.name + ' [未发布]'
      [type_name, item.id]
    end
  end
end
