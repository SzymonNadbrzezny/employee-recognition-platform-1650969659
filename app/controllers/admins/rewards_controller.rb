module Admins
  class RewardsController < AdminsController
    require 'csv'
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
      reward.category_ids = params[:category_ids]
      if reward.save
        redirect_to admins_rewards_path, notice: 'Reward was successfully created.'
      else
        render :new, locals: { reward: reward }
      end
    end

    def import
      rewards_file = params[:reward_file].open
      result = RewardImporter.call(rewards_file)
      if result.success?
        redirect_to admins_rewards_path, notice: "Successfuly imported #{result.value!(:count)} rewards."
      else
        flash.now[:alert] = "Error occured during importing.
                             #{result.failure[:error]} in row: #{result.failure[:row]}
                            "
        render :import_form
      end
    end

    def import_form
      render :import_form
    end

    def destroy
      reward.destroy
      redirect_to admins_rewards_url, notice: 'Reward was successfully destroyed.'
    end

    def update
      reward.category_ids = params[:category_ids]
      reward.picture.attach(params[:picture])
      if reward.update(reward_params)
        redirect_to admins_rewards_path, notice: 'Reward was successfully updated.'
      else
        render :edit, locals: { reward: reward }
      end
    end

    private

    def rewards_hash(rewards_array)
      rewards = rewards_array.map { |r| r.map!(&:strip) }
      headers = rewards.shift.map(&:to_sym)
      rewards.map! { |row| row.map.with_index { |v, i| [headers[i], v] }.to_h }
    end

    def reward
      @reward ||= Reward.find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :picture, :category_ids, :delivery_method)
    end
  end
end
