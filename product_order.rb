class ProductOrder < ApplicationRecord
  belongs_to :user
  has_one :product_shipping_address
  has_many :product_order_items, dependent: :destroy
  has_one :product_shipment, dependent: :destroy

  before_create do
    self.order_number = Services::UniqueNumberGenerator.call(ProductOrder)
  end

  enum status: { unpaid: 'unpaid',
                 paid: 'paid',
                 delivered: 'delivered',
                 completed: 'completed',
                 canceled: 'canceled',
                 returning: 'returning',
                 returned: 'returned' }

  def cancel_order(reason = '')
    update(cancel_reason: reason,
           cancelled_at: Time.zone.now,
           status: 'canceled')
  end

  def shipped
    update(status: 'delivered', shipping_status: 'delivered')
  end
end