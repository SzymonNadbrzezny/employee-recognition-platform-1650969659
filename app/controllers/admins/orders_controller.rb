module Admins
  class OrdersController < AdminsController
    require 'csv'
    def deliver
      if order.update(status: :delivered)
        NotificationsMailer.with(employee: order.buyer, order: order).notify_of_delivery.deliver_later
        redirect_to admins_employee_path(order.buyer), notice: 'Order was successfully updated.'
      else
        redirect_to admins_employee_path(order.buyer), notice: 'Order was not updated.'
      end
    end

    def export
      orders = Order.all
      respond_to do |format|
        format.csv do
          response.headers['Content-Type'] = 'text/csv'
          response.headers['Content-Disposition'] = "attachment; filename=orders.csv"
          render template: "/admins/orders/export.csv.erb", locals: {orders: orders}
        end
      end
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end
  end
end
