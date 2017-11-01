class FreSpecial < ApplicationRecord
  has_many :fre_special_provinces
  belongs_to :freight, optional: true
end
