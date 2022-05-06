# frozen_string_literal: true

class Admins::PagesController < ApplicationController
  before_action :authenticate_admin!
  # before_action :configure_sign_in_params, only: [:create]

  # GET /admins
  def dashboard
  end

end
