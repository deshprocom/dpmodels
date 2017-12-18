class Reply < ApplicationRecord
  belongs_to :topic, polymorphic: true
  belongs_to :typeable, polymorphic: true
  belongs_to :user
  has_many :dynamics, as: :typological, dependent: :destroy
  include Typologicalable
end
