# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    return unless resource_class == Employee

    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end
end
