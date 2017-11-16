class ProductOrder < ApplicationRecord
  belongs_to :user
  has_one :product_shipping_address, dependent: :destroy
  has_many :product_order_items, dependent: :destroy
  has_one :product_shipment, dependent: :destroy

  PAY_STATUSES = %w(unpaid paid failed refund)
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

  def cancel_order(reason = '')
    update(cancel_reason: reason,
           cancelled_at: Time.zone.now,
           status: 'canceled')
  end

  def delivered!
    update(status: 'delivered', delivered: true)
  end
end