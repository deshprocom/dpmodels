class CrowdfundingCategory < ApplicationRecord
  belongs_to :crowdfunding

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end
end