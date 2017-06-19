=begin
+----------------+--------------+------+-----+----------+----------------+
| Field          | Type         | Null | Key | Default  | Extra          |
+----------------+--------------+------+-----+----------+----------------+
| id             | int(11)      | NO   | PRI | NULL     | auto_increment |
| user_id        | int(11)      | YES  | MUL | NULL     |                |
| ticket_id      | int(11)      | YES  | MUL | NULL     |                |
| race_id        | int(11)      | YES  | MUL | NULL     |                |
| ticket_type    | varchar(30)  | YES  |     | e_ticket |                |
| email          | varchar(255) | YES  |     | NULL     |                |
| address        | varchar(255) | YES  |     | NULL     |                |
| consignee      | varchar(50)  | YES  |     | NULL     |                |
| mobile         | varchar(50)  | YES  |     | NULL     |                |
| order_number   | varchar(30)  | YES  | UNI | NULL     |                |
| price          | int(11)      | NO   |     | NULL     |                |
| original_price | int(11)      | NO   |     | NULL     |                |
| status         | varchar(30)  | YES  | MUL | unpaid   |                |
| created_at     | datetime     | NO   |     | NULL     |                |
| updated_at     | datetime     | NO   |     | NULL     |                |
+----------------+--------------+------+-----+----------+----------------+
=end
class PurchaseOrder < ApplicationRecord
  belongs_to :user
  belongs_to :race
  belongs_to :ticket
  has_one :snapshot, class_name: OrderSnapshot
  has_many :syslogs, as: :operation, class_name: AdminSysLog

  validates :order_number, presence: true
  enum status: { unpaid: 'unpaid', paid: 'paid', completed: 'completed', canceled: 'canceled' }

  after_initialize do
    self.order_number ||= Services::UniqueNumberGenerator.call(PurchaseOrder)
  end

  after_create do
    create_snapshot(race.to_snapshot)
    Notification.notify_order(self)
  end

  after_update do
    Notification.notify_order(self) if status_changed? && !canceled?
  end

  scope :formal_order, -> { where.not(status: 'canceled') }
  scope :unpaid, -> { where(status: 'unpaid') }
  scope :paid, -> { where(status: 'paid') }
  scope :completed, -> { where(status: 'completed') }
  scope :canceled, -> { where(status: 'canceled') }

  def self.purchased?(user_id, race_id)
    where(user_id: user_id).where(race_id: race_id).formal_order.exists?
  end

  def self.purchased_order(user_id, race_id)
    where(user_id: user_id).where(race_id: race_id).formal_order.first
  end
end
