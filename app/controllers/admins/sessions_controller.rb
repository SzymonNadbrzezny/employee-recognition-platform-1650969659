# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    def after_sign_out_path_for(_resource)
      admin_session_path
    end
  end
end
