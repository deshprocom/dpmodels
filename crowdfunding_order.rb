class CrowdfundingOrder < ApplicationRecord
  belongs_to :user
  belongs_to :crowdfunding_player
  belongs_to :crowdfunding

  before_create do
    self.order_number = Services::UniqueNumberGenerator.call(CrowdfundingOrder)
  end

  default_scope { where(deleted: false) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  enum record_status: { unpublished: 'unpublished', success: 'success', failed: 'failed' }

  def deleted!
    update(deleted: true)
  end

  def paid!
    update(paid: true)
  end
end