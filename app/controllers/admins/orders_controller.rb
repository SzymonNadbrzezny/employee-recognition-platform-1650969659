module Admins
  class OrdersController < AdminsController
    def deliver
      if order.update(status: :delivered)
        redirect_to admins_employee_path(order.buyer), notice: 'Order was successfully updated.'
      else
        redirect_to admins_employee_path(order.buyer), notice: 'Order was not updated.'
      end
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end
  end
end
