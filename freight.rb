class Freight < ApplicationRecord
  has_many :fre_specials
  has_many :fre_special_provinces, through: :fre_specials

  def find_province_freight(province)
    fre_special_provinces.find_by(province_name: province)&.fre_special || self
  end

  def default!
    update(default: true)
  end

  def no_default!
    update(default: false)
  end

  def product_freight(condition, destination)
    obj = fre_special_provinces.where(province_name: destination)
    return obj.first.fre_special.calculate(condition) if obj.exists?
    calculate(condition)
  end

  def calculate(condition)
    diff = condition - first_cond
    return first_price if diff <= 0
    first_price + (diff / add_cond).ceil * add_price
  end
end
