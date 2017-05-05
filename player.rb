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
  mount_uploader :avatar, AvatarUploader
  has_many :race_ranks
  attr_accessor :avatar_path

  validates :name, :country, presence: true
  validates :name, uniqueness: { scope: :country }

  before_save do
    self.player_id = SecureRandom.hex(4) if created_at.blank?
  end

  # 上传图片给图片赋值的时候 创建图片路径
  def avatar=(value)
    super
    # rubocop:disable Style/GuardClause
    if avatar.file.present? && avatar.file.respond_to?(:path) && File.exist?(avatar.file.path)
      self.avatar_md5 = Digest::MD5.file(avatar.file.path).hexdigest
    end
  end

  def avatar_path
    return '' if avatar.url.nil?

    avatar.url
  end
end
