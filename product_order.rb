class ProductOrder < ApplicationRecord
  belongs_to :user
  has_many :product_order_items, dependent: :destroy

  before_create do
    self.order_number = Services::UniqueNumberGenerator.call(ProductOrder)
  end
end