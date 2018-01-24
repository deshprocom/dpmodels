class CrowdfundingRank < ApplicationRecord
  belongs_to :race
  belongs_to :player
  belongs_to :crowdfunding
  belongs_to :crowdfunding_player

  before_save do
    self.sale_amount = (earning - deduct_tax) * crowdfunding_player.sell_stock / 100
    self.total_amount = platform_tax.zero? ? sale_amount : sale_amount * platform_tax / 100
    self.end_date = race&.end_date
  end

  def self.update_or_create(attributes)
    assign_or_new(attributes).save
  end

  def self.assign_or_new(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end
end
