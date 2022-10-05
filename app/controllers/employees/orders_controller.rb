module Employees
  class OrdersController < EmployeesController
    def index
      if params[:id].to_i == current_employee.id
        orders = OrdersQuery.new(current_employee.orders).call(params)
        render :index, locals: { orders: orders }
      else
        redirect_to orders_employee_path(current_employee.id)
      end
    end

    def show
      reward = order.reward
      render :show, locals: { order: order, reward: reward }
    end

    def new
      order_form = OrderForm.new
      reward = Reward.find(params[:format])
      render :new, locals: { order_form: order_form, reward: reward, employee: current_employee }
    end

    def create
      order_form = OrderForm.new(order_form_params)
      reward = Reward.find(order_form.reward_id)
      order_form.employee = current_employee
      if order_form.employee.points < reward.price
        redirect_to rewards_path, alert: 'Not enough points'
      elsif order_form.save
        order_form.employee.decrement(:points, reward.price).save
        redirect_to rewards_path, notice: 'Order was successfully created.'
      else
        render :new, locals: { order_form: order_form, reward: reward, employee: current_employee }
      end
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end

    def order_form_params
      params.require(:order_form).permit(:reward_id, :street, :city, :postal_code, :address_id)
    end
  end
end
