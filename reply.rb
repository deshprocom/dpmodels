class Reply < ApplicationRecord
  belongs_to :topic, polymorphic: true
  belongs_to :comment
  belongs_to :user
  has_many :dynamics, as: :typological, dependent: :destroy
  has_many :replies, class_name: 'Reply', foreign_key: 'reply_id', dependent: :destroy
  belongs_to :reply, optional: true
  include Typologicalable
end
