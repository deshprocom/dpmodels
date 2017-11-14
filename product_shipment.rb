class ProductShipment < ApplicationRecord
  belongs_to :express_code, optional: true
  belongs_to :product_order
end