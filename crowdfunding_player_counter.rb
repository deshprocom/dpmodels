class CrowdfundingPlayerCounter < ApplicationRecord
  belongs_to :crowdfunding_player
  belongs_to :crowdfunding
  before_create do
    self.crowdfunding = crowdfunding_player.crowdfunding
  end
end