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
      order = Order.new
      reward = Reward.find_by(id: params[:format])
      order.reward = reward
      render :new, locals: { order: order, reward: reward }
    end

    def create
      @order = Order.new(order_params)
      order.reward_price = order.reward.price
      order.buyer = current_employee
      if order.buyer.points < order.reward_price
        redirect_to rewards_path, alert: 'Not enough points'
      elsif order.save
        order.buyer.decrement(:points, order.reward_price).save
        redirect_to rewards_path, notice: 'Order was successfully created.'
      else
        render :new, locals: { order: order, reward: reward }
      end
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:reward_id)
    end
  end
end
