module Employees
  class RewardsController < EmployeesController
    def index
      @rewards = RewardsQuery.new(params, is_using_pictures: true).call.page params[:page]
      categories = Category.all
      valid_category = categories.map(&:title).include?(params[:category])
      render :index, locals: { rewards: @rewards, categories: categories, valid_category: valid_category }
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
