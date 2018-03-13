class ProductOrder < ApplicationRecord
  belongs_to :user

  has_one :product_shipping_address, dependent: :destroy
  has_many :product_order_items, dependent: :destroy
  has_many :product_wx_bills, dependent: :destroy
  has_one :product_shipment, dependent: :destroy
  include DeductionResult

  PAY_STATUSES = %w(unpaid paid failed refund).freeze
  validates :pay_status, inclusion: { in: PAY_STATUSES }

  enum status: { unpaid: 'unpaid',
                 paid: 'paid',
                 delivered: 'delivered',
                 completed: 'completed',
                 canceled: 'canceled',
                 returning: 'returning',
                 returned: 'returned' }

  before_create do
    self.order_number = Services::UniqueNumberGenerator.call(ProductOrder)
  end

  default_scope { where(deleted: false) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  def cancel_order(reason = '取消订单')
    return if canceled?
    update(cancel_reason: reason, cancelled_at: Time.zone.now, status: 'canceled')
    product_order_items.each do |item|
      item.variant.increase_stock(item.number)
      next if item.variant.is_master?

      item.variant.product.master.increase_stock(item.number)
    end
    # 将扑客币的数量添加上去
    if deduction && deduction_result.eql?('success')
      PokerCoin.deduction(self, '商品订单返还扑客币', deduction_numbers, '+')
      deduction_success
    else
      true
    end
  end

  def delivered!
    update(status: 'delivered', delivered: true, delivered_time: Time.zone.now)
  end

  def completed!
    update(status: 'completed', completed_time: Time.zone.now)
  end

  def deleted!
    update(deleted: true)
  end

  def could_delete?
    canceled? || completed?
  end

  def self.unpaid_half_an_hour
    unpaid.where('created_at < ?', 30.minutes.ago)
  end

  def could_refund?
    paid? || (delivered? && delivered_time.present? && delivered_time > 15.days.ago)
  end

  def self.delivered_15_days
    delivered.where('delivered_time < ?', 15.days.ago)
  end
end
