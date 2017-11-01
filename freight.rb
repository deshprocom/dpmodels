class Freight < ApplicationRecord
  has_many :fre_specials
  has_many :fre_special_provinces, through: :fre_specials
end
