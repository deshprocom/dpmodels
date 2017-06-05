##
# 票数计数器
#
module TicketNumberCounter
  extend ActiveSupport::Concern

  def return_a_e_ticket
    ticket_info.decrement!(:e_ticket_sold_number)
  end
end
