class ExpressCode < ApplicationRecord
  has_many :product_shipments

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'
end
