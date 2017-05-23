class Notification < ApplicationRecord
  belongs_to :source, polymorphic: true

  def self.place_order(order)
    content = '恭喜您，下单成功！客服将及时与您联系，请保持手机通话畅通！'
    Notification.create(notify_type: 'order',
                        user_id: order.user_id,
                        source: order,
                        content: content,
                        title: generate_order_title(order))
  end

  def self.generate_order_title(order)
    "订单编号: #{order.order_number} #{order.created_at.strftime('%Y-%m-%d')}"
  end
end
