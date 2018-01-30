class CrowdfundingReport < ApplicationRecord
  belongs_to :crowdfunding
  belongs_to :crowdfunding_player, optional: true

  after_initialize do
    self.record_time ||= Time.now
  end

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end
end
