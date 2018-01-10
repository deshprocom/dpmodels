class Crowdfunding < ApplicationRecord
  mount_uploader :master_image, CrowdfundingUploader

  belongs_to :race
  has_many :players

  after_initialize do
    self.expire_date ||= Date.current
    self.publish_date ||= Date.current
    self.award_date ||= Date.current
  end

  def preview_image
    return '' if master_image.url.nil?

    master_image.url(:sm)
  end
end
