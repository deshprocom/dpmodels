class Crowdfunding < ApplicationRecord
  has_one :race
  mount_uploader :master_image, CrowdfundingUploader
  include Publishable
  after_create do
    create_default_category
  end

  belongs_to :race
  has_many :players
  has_many :crowdfunding_categories, -> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :crowdfunding_categories, allow_destroy: true
  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  after_initialize do
    self.expire_date ||= Date.current
    self.publish_date ||= Date.current
    self.award_date ||= Date.current
  end

  def preview_image
    return '' if master_image.url.nil?

    master_image.url(:sm)
  end

  def create_default_category
    crowdfunding_categories.create(name: '项目介绍', description: race&.race_desc&.description)
    %w(众筹概况 项目公告 投资风险).each { |name| crowdfunding_categories.create(name: name) }
  end
end
