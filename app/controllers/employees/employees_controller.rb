module Employees
  class EmployeesController < ApplicationController
    # before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_employee!

    def show
      render :show, locals: { employee: current_employee }
    end

    def edit
      render :edit, locals: { employee: current_employee }
    end

    def update
      if current_employee.update(employee_params)
        redirect_to employee_path(current_employee), notice: 'Employee was successfully updated.'
      else
        render :edit, locals: { employee: current_employee }
      end
    end

    def pundit_user
      current_employee
    end

    private

    def employee_params
      params.require(:employee).permit(:first_name, :last_name)
    end
  end
end
