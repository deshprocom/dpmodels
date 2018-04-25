# 创建用户生成器
# rubocop:disable Metrics/MethodLength
module UserCreator
  extend ActiveSupport::Concern

  module ClassMethods
    def create_by_mobile(mobile, password, remote_ip)
      user_attrs = new_user_attributes(mobile: mobile, password: password, remote_ip: remote_ip)
      User.create(user_attrs)
    end

    def create_by_email(email, password, remote_ip)
      user_attrs = new_user_attributes(email: email, password: password, remote_ip: remote_ip)
      User.create(user_attrs)
    end

    def new_user_attributes(user_attrs = {})
      default_attrs = user_attrs.dup
      password = default_attrs.delete(:password)
      password ||= ::Digest::MD5.hexdigest(SecureRandom.uuid)
      salt = SecureRandom.hex(6).slice(0, 6)
      salted_password = ::Digest::MD5.hexdigest("#{password}#{salt}")
      user_name = User.unique_username
      nick_name = user_name
      remote_ip = default_attrs.delete(:remote_ip)

      { user_uuid: SecureRandom.hex(16),
        user_name: user_name,
        nick_name: nick_name,
        password: salted_password,
        password_salt: salt,
        gender: 2,
        reg_date: Time.zone.now,
        last_login_ip: remote_ip,
        current_login_ip: remote_ip,
        last_visit: Time.zone.now }.merge!(default_attrs)
    end
  end
end
