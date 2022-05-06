# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_controller?


  def current_controller?(names)
    controller = Rails.application.routes.recognize_path(request.path)[:controller]
    controller.start_with?(names)
  end

end
