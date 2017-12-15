class Comment < ApplicationRecord
  belongs_to :topic, polymorphic: true
  has_many :replies, as: :typeable, dependent: :destroy
  belongs_to :user
  has_many :dynamics, as: :typological, dependent: :destroy
  include Typologicalable
end
