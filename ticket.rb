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

  belongs_to :race
  has_one :ticket_info
end
