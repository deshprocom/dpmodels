class InfoType < ApplicationRecord
  include Publishable

  has_many :infos, dependent: :destroy
  has_one :info_type_en, foreign_key: 'id', dependent: :destroy
  accepts_nested_attributes_for :info_type_en, update_only: true
  validates :name, presence: true

  scope :published, -> { where(published: true) }

  after_update do
    info_type_en || build_info_type_en
    info_type_en.save
  end

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  def self.info_type_array
    all.collect do |item|
      type_name = item.published ? item.name + ' [已发布]' : item.name + ' [未发布]'
      [type_name, item.id]
    end
  end
end
