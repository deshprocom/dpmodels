class CrowdfundingOrder < ApplicationRecord
  belongs_to :user
  belongs_to :crowdfunding_player
  belongs_to :crowdfunding
  belongs_to :user_extra, optional: true

  before_create do
    self.order_number = Services::UniqueNumberGenerator.call(CrowdfundingOrder)
  end

  default_scope { where(deleted: false) } unless ENV['CURRENT_PROJECT'] == 'dpcms'
  scope :paid_status, -> { where(paid: true) }

  enum record_status: { unpublished: 'unpublished', success: 'success', failed: 'failed' }

  def deleted!
    update(deleted: true)
  end

  def paid!
    update(paid: true)
  end

  def self.past_buy_number(cf_player, user)
    where(paid: true).where(crowdfunding_player: cf_player).where(user: user).sum(&:order_stock_number)
  end
end