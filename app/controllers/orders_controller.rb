class OrdersController < ApplicationController
  # GET /orders
  def index
    if params[:id].to_f == current_employee.id
      render :index, locals: { orders: Order.where(buyer_id: params[:id]) }
    else
      redirect_to orders_employee_path(current_employee.id)
    end
  end

  # GET /orders/1
  def show
    reward = JSON.parse(order.reward)
    render :show, locals: { order: order, reward: reward }
  end

  # GET /orders/new
  def new
    order = Order.new
    reward = Reward.find_by(id: params[:format])
    order.reward = reward
    render :new, locals: { order: order, reward: reward }
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    ordered_reward = JSON.parse(order.reward)
    reward = Reward.find_by(id: JSON.parse(order.reward)['id'])
    order.buyer = current_employee
    if order.buyer.points < ordered_reward['price'].to_f
      redirect_to rewards_path, alert: 'Not enough points'
    elsif order.save
      order.buyer.decrement(:points, ordered_reward['price'].to_f).save
      redirect_to rewards_path, notice: 'Order was successfully created.'
    else
      render :new, locals: { order: order, reward: reward }
    end
  end

  # DELETE /orders/1
  def destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def order
    @order ||= Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:reward)
  end
end
