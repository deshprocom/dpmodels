class ProductShippingAddress < ApplicationRecord
  has_many :product_orders

  def full_address
    province.to_s + city.to_s + area.to_s + address.to_s
  end
end