module Admins
  class AdminsController < ApplicationController
    before_action :authenticate_admin!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    layout 'admin'

    def pundit_user
      current_admin
    end

    private

    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore
      flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
      redirect_back(fallback_location: admins_root_path)
    end
  end
end
