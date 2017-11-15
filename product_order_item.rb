class ProductOrderItem < ApplicationRecord
  belongs_to :product_order
  belongs_to :variant

  before_create :init
  after_create :generate_order_data

  def init
    self.original_price = variant.original_price
    self.price = variant.price
    option_values = variant&.option_values
    return unless option_values
    self.sku_value = option_values.collect do |option|
      { option.option_type.name => option.name }
    end
  end

  def generate_order_data
    total = number * price
    product_order.increment!(:total_product_price, total)
    product_order.increment!(:total_price, total)
  end

  def refunded!
    update(refunded: true)
  end
end