class Player < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  attr_accessor :avatar_path

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
    ENV['CMS_PHOTO_PATH'].to_s + avatar.to_s unless avatar.to_s.blank?
  end
end
