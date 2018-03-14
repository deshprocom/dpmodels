class AdminRole < ApplicationRecord
  has_and_belongs_to_many :admin_users, join_table: :admin_users_roles
  serialize :permissions, JSON

  def permissions_text
    @permissions_text ||= permissions.inject('') do |text, item|
      "#{text} #{I18n.t("activerecord.models.#{item}")}"
    end
  end
end