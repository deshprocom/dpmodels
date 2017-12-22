class TopicLike < ApplicationRecord
  belongs_to :topic, -> { unscope(:where) }, polymorphic: true
  belongs_to :user
  has_many :dynamics, as: :typological, dependent: :destroy
  include Typologicalable
end
