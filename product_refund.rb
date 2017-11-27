class ProductRefund < ApplicationRecord
  belongs_to :product_order_item
  has_many :product_refund_images, dependent: :destroy
end
