=begin
+----------------+--------------+------+-----+---------+----------------+
| Field          | Type         | Null | Key | Default | Extra          |
+----------------+--------------+------+-----+---------+----------------+
| id             | int(11)      | NO   | PRI | NULL    | auto_increment |
| race_id        | int(11)      | YES  | MUL | NULL    |                |
| title          | varchar(256) | YES  |     | NULL    |                |
| logo           | varchar(256) | YES  |     | NULL    |                |
| price          | int(11)      | YES  |     | NULL    |                |
| original_price | int(11)      | YES  |     | NULL    |                |
| created_at     | datetime     | NO   |     | NULL    |                |
| updated_at     | datetime     | NO   |     | NULL    |                |
| ticket_class   | varchar(255) | YES  |     | race    |                |
| description    | text         | YES  |     | NULL    |                |
| status         | varchar(30)  | YES  |     | unsold  |                |
+----------------+--------------+------+-----+---------+----------------+
=end

class Ticket < ApplicationRecord
  include TicketNumberCounter

  # 增加二级查询缓存，缓存过期时间六小时
  second_level_cache(version: 1, expires_in: 6.hours)

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end
  after_update { ticket_en&.save }

  after_update { ticket_en&.save }

  belongs_to :race
  has_many :orders, class_name: PurchaseOrder
  has_one :ticket_info, dependent: :destroy
  accepts_nested_attributes_for :ticket_info, update_only: true
  has_one :ticket_en, foreign_key: :id, dependent: :destroy
  accepts_nested_attributes_for :ticket_en, update_only: true

  enum status: { unsold: 'unsold', selling: 'selling', end: 'end', sold_out: 'sold_out' }
  enum ticket_class: { single_ticket: 'single_ticket', package_ticket: 'package_ticket' }

  validates :ticket_class, uniqueness: { scope: :race_id }, if: :single_ticket?
  validates :title, :price, :original_price, :ticket_class, presence: true

  scope :not_sold_out, -> { where.not(status: 'sold_out') }
  scope :tradable, -> { where(status: %w(selling sold_out)) }
end
