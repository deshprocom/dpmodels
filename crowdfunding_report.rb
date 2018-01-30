class CrowdfundingReport < ApplicationRecord
  belongs_to :crowdfunding
  belongs_to :crowdfunding_player
end
