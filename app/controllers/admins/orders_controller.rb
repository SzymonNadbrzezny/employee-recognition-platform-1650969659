module Admins
  class OrdersController < AdminsController
    # GET /orders
    def index
      employee=Employee.where(id:params[:id])[0]
      render :index, locals: { orders: Order.where(buyer_id: params[:id]), employee: employee }
    end

    # GET /orders/1
    def show
      reward = order.reward.to_json
      render :show, locals: { order: order, reward: reward }
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def order
      @order ||= Order.find(params[:id])
    end
  end
end
