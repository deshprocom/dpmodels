class Freight < ApplicationRecord
  has_many :fre_specials
  has_many :fre_special_provinces, through: :fre_specials

  def default!
    update(default: true)
  end

  def no_default!
    update(default: false)
  end
end
