class Notification < ApplicationRecord
  belongs_to :source, polymorphic: true

  def self.notify_order(order)
    title = "订单编号: #{order.order_number} #{order.created_at.strftime('%Y-%m-%d')}"
    Notification.create(notify_type: 'order',
                        user_id: order.user_id,
                        source: order,
                        content: notify_order_content(order),
                        title: title)
  end

  def self.notify_order_content(order)
    if order.status == 'unpaid'
      '恭喜您，下单成功！客服将及时与您联系，请保持手机通话畅通！'
    elsif order.status == 'paid'
      '付款成功！'
    elsif order.status == 'completed'
      "您已成功参与#{order.race.name}，请及时查收预留的收货方式收取赛票，感谢您对扑客的支持！"
    end
  end
end
