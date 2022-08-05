module Employees
  class EmployeesController < ApplicationController
    before_action :authenticate_employee!
    def pundit_user
      current_employee
    end
  end
end
