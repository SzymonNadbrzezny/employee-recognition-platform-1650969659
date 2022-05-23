module Admins
  class RewardsController < AdminsController
    def index
      render :index, locals: { rewards: Reward.all }
    end

    def new
      render :new, locals: { reward: Reward.new }
    end

    def show
      render :show, locals: { reward: reward }
    end

    def edit
      render :edit, locals: { reward: reward }
    end

    def create
      @reward = Reward.new(reward_params)

      if reward.save
        redirect_to admins_rewards_path, notice: 'Reward was successfully created.'
      else
        render :new, locals: { reward: reward }
      end
    end

    def destroy
      reward.destroy
      redirect_to admins_rewards_url, notice: 'Reward was successfully destroyed.'
    end

    def update
      if reward.update(reward_params)
        redirect_to admins_rewards_path, notice: 'Reward was successfully updated.'
      else
        render :edit, locals: { reward: reward }
      end
    end

    private

    def reward
      @reward ||= Reward.find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:title, :description, :price)
    end
  end
end
