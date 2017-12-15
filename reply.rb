class Reply < ApplicationRecord
  belongs_to :comment
  belongs_to :user
  has_many :dynamics, as: :typological, dependent: :destroy
  include Typologicalable
end
