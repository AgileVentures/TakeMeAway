module OrdersHelper

  def status_color(order)
    case order.status
      when 'pending'
        :warn
      when 'processed'
        :ok
      when 'canceled'
        :no
    end
  end

end