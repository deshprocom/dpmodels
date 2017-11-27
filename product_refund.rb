class ProductRefund < ApplicationRecord
  belongs_to :product_order_item
  belongs_to :product_refund_type
  has_many :product_refund_images, dependent: :destroy
end
