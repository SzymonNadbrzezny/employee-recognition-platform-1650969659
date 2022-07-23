module Admins
  class OrdersController < AdminsController
    def update
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

    def order_params
      params.require(:order).permit(:status)
    end
  end
end
