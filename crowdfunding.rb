class Crowdfunding < ApplicationRecord
  mount_uploader :master_image, CrowdfundingUploader

  belongs_to :race
  has_many :players
  has_many :crowdfunding_categories, dependent: :destroy
  accepts_nested_attributes_for :crowdfunding_categories, :allow_destroy => true, reject_if: :new_record?

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
