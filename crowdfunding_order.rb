class CrowdfundingOrder < ApplicationRecord
  belongs_to :user
  belongs_to :crowdfunding_player
  belongs_to :crowdfunding

  before_create do
    self.order_number = Services::UniqueNumberGenerator.call(CrowdfundingOrder)
  end
end