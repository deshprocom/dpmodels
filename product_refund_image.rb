class ProductRefundImage < ApplicationRecord
  mount_uploader :image, RefundUploader
  belongs_to :product_refund
end
