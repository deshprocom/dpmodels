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

  after_create do
    player.increment!(:dpi_total_earning, earning) if earning.positive?
    player.increment!(:dpi_total_score, score) if score.positive?
  end

  after_destroy do
    player.decrement!(:dpi_total_earning, earning) if earning.positive?
    player.decrement!(:dpi_total_score, score) if score.positive?
  end

  after_update do
    if player_id == player_id_was
      update_player_data
    else
      replace_player_data
    end
  end

  def update_player_data
    earning_d_val = earning - earning_was
    score_d_val   = score - score_was
    player.increment!(:dpi_total_earning, earning_d_val) unless earning_d_val.zero?
    player.increment!(:dpi_total_score, score_d_val) unless score_d_val.zero?
  end

  def replace_player_data
    player.increment!(:dpi_total_earning, earning) if earning.positive?
    player.increment!(:dpi_total_score, score) if score.positive?

    old_player = Player.find player_id_was
    old_player.decrement!(:dpi_total_earning, earning_was) if earning_was.positive?
    old_player.decrement!(:dpi_total_score, score_was) if score_was.positive?
  end
end
