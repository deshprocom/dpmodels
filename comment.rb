class Comment < ApplicationRecord
  belongs_to :topic, polymorphic: true, unscoped: true
  has_many :replies, dependent: :destroy
  belongs_to :user
  has_many :dynamics, as: :typological, dependent: :destroy
  include Typologicalable
  include Recommendable

  default_scope { where(deleted: false) }

  def admin_delete(reason = '')
    update(deleted_reason: reason, deleted_at: Time.zone.now, deleted: true)
    Dynamic.create(user: User.official, typological: self, option_type: 'delete')
  end

  def self.recommend_comments
    where(recommended: true)
  end
end
