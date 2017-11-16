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
end
