class CrowdfundingPlayer < ApplicationRecord
  include Publishable
  belongs_to :crowdfunding
  belongs_to :player
  has_one :counter, class_name: 'CrowdfundingPlayerCounter'
  accepts_nested_attributes_for :player
  validates :player_id, :sell_stock, :stock_number,
            :stock_unit_price, :cf_money, :limit_buy, presence: true
  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'
  include CrowdfundingPlayerCountable
end