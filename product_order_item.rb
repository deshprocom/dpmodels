class ProductOrderItem < ApplicationRecord
  belongs_to :product_order
  belongs_to :variant

  after_create do
    total = number * price
    self.product_order.increment!(:total_product_price, total)
  end
end