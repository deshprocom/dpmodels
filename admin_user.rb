class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  if ENV['CURRENT_PROJECT'] == 'dpcms'
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  end
  has_many :syslogs, class_name: AdminSysLog
  has_and_belongs_to_many :admin_roles, join_table: :admin_users_roles

  def permissions
    @permissions ||= admin_roles.map(&:permissions).flatten.uniq
  end
end