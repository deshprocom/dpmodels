class InviteCode < ApplicationRecord
  # 生成邀请码，唯一性
  before_create :generate_code
  validates :name, presence: true, uniqueness: true
  has_many :orders, class_name: 'PurchaseOrder', foreign_key: :invite_code, primary_key: :code

  def order_count
    orders.count
  end

  def success_count
    orders.where.not(status: ['unpaid', 'canceled']).count
  end

  protected

  def generate_code
    self.code = loop do
      random_code = ('A'..'Z').to_a.sample(4).join
      break random_code unless InviteCode.exists?(code: random_code)
    end
  end
end
