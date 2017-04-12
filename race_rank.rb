=begin
+-----------+---------+------+-----+---------+----------------+
| Field     | Type    | Null | Key | Default | Extra          |
+-----------+---------+------+-----+---------+----------------+
| id        | int(11) | NO   | PRI | NULL    | auto_increment |
| race_id   | int(11) | YES  | MUL | NULL    |                |
| player_id | int(11) | YES  | MUL | NULL    |                |
| ranking   | int(11) | YES  |     | NULL    |                |
| earning   | int(11) | YES  |     | NULL    |                |
| score     | int(11) | YES  |     | NULL    |                |
+-----------+---------+------+-----+---------+----------------+
=end
class RaceRank < ApplicationRecord
  belongs_to :race
  belongs_to :player

  validates :player_id, presence: true
  default_scope -> { order(ranking: :asc) }
end
