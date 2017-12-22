class Reply < ApplicationRecord
  belongs_to :topic, -> { unscope(:where) }, polymorphic: true
  belongs_to :comment
  belongs_to :user
  has_many :dynamics, as: :typological, dependent: :destroy
  has_many :replies, class_name: 'Reply', foreign_key: 'reply_id', dependent: :destroy
  belongs_to :reply, optional: true
  include Typologicalable

  default_scope { where(deleted: false) }

  def admin_delete(reason = '')
    update(deleted_reason: reason, deleted_at: Time.zone.now, deleted: true)
    Dynamic.create(user: User.official, typological: self, option_type: 'delete')
  end
end
