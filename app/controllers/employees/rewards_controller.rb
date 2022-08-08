module Employees
  class RewardsController < EmployeesController
    def index
      @rewards = Reward.page params[:page]
      render :index, locals: { rewards: @rewards }
    end

    def show
      render :show, locals: { reward: reward }
    end

    private

    def reward
      @reward ||= Reward.find(params[:id])
    end
  end
end
