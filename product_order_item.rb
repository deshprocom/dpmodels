class ProductOrderItem < ApplicationRecord
  belongs_to :product_order
  belongs_to :variant

  before_create :generate_snapshot

  after_create do
    total = number * price
    self.product_order.increment!(:total_product_price, total)
  end


  def generate_snapshot
    self.original_price = variant.original_price
    self.price = variant.price
    option_values = variant&.option_values
    return unless option_values
    self.sku_value = option_values.collect do |option|
      { option.option_type.name => option.name }
    end
  end
end