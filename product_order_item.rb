class ProductOrderItem < ApplicationRecord
  belongs_to :product_order
  belongs_to :variant
  has_one :product_refund_detail, dependent: :destroy

  before_save :syn_variant
  serialize :sku_value, JSON

  def syn_variant
    self.original_price ||= variant.original_price
    self.price     ||= variant.price
    self.sku_value ||= variant.text_sku_values
  end

  def refunded!
    update(refunded: true)
  end
end