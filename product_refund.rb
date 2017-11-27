class ProductRefund < ApplicationRecord
  belongs_to :product_order_item
  belongs_to :product_refund_type
  has_many :product_refund_images, dependent: :destroy

  before_create do
    self.refund_number = ::Digest::MD5.hexdigest(SecureRandom.uuid)
  end
end
