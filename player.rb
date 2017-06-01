=begin
+-------------------+--------------+------+-----+---------+----------------+
| Field             | Type         | Null | Key | Default | Extra          |
+-------------------+--------------+------+-----+---------+----------------+
| id                | int(11)      | NO   | PRI | NULL    | auto_increment |
| player_id         | varchar(32)  | YES  |     | NULL    |                |
| name              | varchar(255) | YES  |     |         |                |
| avatar            | varchar(100) | YES  |     | NULL    |                |
| gender            | varchar(255) | YES  |     | 0       |                |
| country           | varchar(255) | YES  |     |         |                |
| dpi_total_earning | int(11)      | YES  |     | NULL    |                |
| gpi_total_earning | int(11)      | YES  |     | NULL    |                |
| dpi_total_score   | int(11)      | YES  |     | NULL    |                |
| gpi_total_score   | int(11)      | YES  |     | NULL    |                |
| memo              | varchar(255) | YES  |     |         |                |
| created_at        | datetime     | NO   |     | NULL    |                |
| updated_at        | datetime     | NO   |     | NULL    |                |
| avatar_md5        | varchar(32)  | NO   |     |         |                |
+-------------------+--------------+------+-----+---------+----------------+
=end
class Player < ApplicationRecord
  mount_uploader :avatar, PlayerUploader
  has_many :race_ranks
  attr_accessor :avatar_path
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  validates :name, :country, presence: true
  validates :name, uniqueness: { scope: :country }

  before_save do
    self.player_id = SecureRandom.hex(4) if created_at.blank?
  end

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def avatar_thumb
    return '' if avatar.thumb.url.nil?
    avatar.thumb.url + "?suffix=#{Time.now.to_i}"
  end
end
