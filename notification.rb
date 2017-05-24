class Notification < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :user

  after_create do
    DpPush::NotifyUser.call(user, content) unless Rails.env.test?
  end

  def self.notify_order(order)
    title = "订单编号: #{order.order_number} #{Time.now.strftime('%Y-%m-%d %T')}"
    Notification.create(notify_type: 'order',
                        user_id: order.user_id,
                        source: order,
                        content: notify_order_content(order),
                        title: title)
  end

  def self.notify_certification(extra)
    title = "实名认证 #{Time.now.strftime('%Y-%m-%d %T')}"
    Notification.create(notify_type: 'certification',
                        user_id: extra.user_id,
                        source: extra,
                        content: notify_certification_content(extra),
                        title: title)
  end

  def self.notify_order_content(order)
    if order.unpaid?
      '恭喜您，下单成功！客服将及时与您联系，请保持手机通话畅通！'
    elsif order.paid?
      '付款成功！'
    elsif order.completed?
      "您已成功参与#{order.race.name}，请及时查收预留的收货方式收取赛票，感谢您对扑客的支持！"
    end
  end

  def self.notify_certification_content(extra)
    if extra.failed?
      "实名认证失败，请重新上传信息认证！失败原因: #{extra.memo}"
    elsif extra.passed?
      '实名认证成功！'
    end
  end
end
