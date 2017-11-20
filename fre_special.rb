class FreSpecial < ApplicationRecord
  has_many :fre_special_provinces, dependent: :destroy
  belongs_to :freight, optional: true

  def calculate(condition)
    diff = condition - first_cond
    return first_price if diff <= 0
    first_price + (diff / add_cond).ceil * add_price
  end
end
