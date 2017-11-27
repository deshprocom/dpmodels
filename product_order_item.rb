class ProductOrderItem < ApplicationRecord
  belongs_to :product_order
  belongs_to :variant
  has_many :product_refunds, dependent: :destroy

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

  def refund_record_permit?
    # 不存在退款记录，或者存在退款记录但是为close状态
    product_refunds.blank? || product_refunds.where(status: %w(open passed completed)).blank?
  end
end