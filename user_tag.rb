class UserTag < ApplicationRecord
  belongs_to :user_tag_map
  has_many :users, through: :user_tag_maps
end
