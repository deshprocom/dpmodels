=begin
+-----------------+--------------+------+-----+----------+----------------+
| Field           | Type         | Null | Key | Default  | Extra          |
+-----------------+--------------+------+-----+----------+----------------+
| id              | int(11)      | NO   | PRI | NULL     | auto_increment |
| user_id         | int(11)      | YES  | MUL | NULL     |                |
| race_id         | int(11)      | YES  | MUL | NULL     |                |
| ticket_infos_id | int(11)      | YES  | MUL | NULL     |                |
| ticket_type     | varchar(30)  | YES  |     | e_ticket |                |
| memo            | varchar(255) | YES  |     | NULL     |                |
| canceled        | tinyint(1)   | YES  |     | 0        |                |
| created_at      | datetime     | NO   |     | NULL     |                |
| updated_at      | datetime     | NO   |     | NULL     |                |
+-----------------+--------------+------+-----+----------+----------------+
=end

class Ticket < ApplicationRecord
  include TicketNumberCounter
  belongs_to :race
  has_many :orders, class_name: PurchaseOrder
  has_one :ticket_info
end
