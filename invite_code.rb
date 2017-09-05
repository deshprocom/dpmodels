class InviteCode < ApplicationRecord
  # 生成邀请码，唯一性
  before_create :generate_code
  validates :name, presence: true, uniqueness: true

  protected

  def generate_code
    self.code = loop do
      random_code = ('A'..'Z').to_a.sample(4).join
      break random_code unless InviteCode.exists?(code: random_code)
    end
  end
end
