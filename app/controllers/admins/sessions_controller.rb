# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    layout 'admin'
    def after_sign_in_path_for(_resource)
      admins_root_path
    end
    def after_sign_out_path_for(_resource)
      admin_session_path
    end
  end
end
