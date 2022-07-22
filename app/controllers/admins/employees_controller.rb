module Admins
  class EmployeesController < AdminsController
    def index
      render :index, locals: { employees: Employee.all }
    end

    def show
      render :show, locals: { employee: employee }
    end

    def edit
      render :edit, locals: { employee: employee }
    end

    def destroy
      employee.destroy
      redirect_to admins_employees_url, notice: 'Employee was successfully destroyed.'
    end

    def update
      if employee_params[:password].empty?
        if employee.update_without_password(employee_params.except(:password))
          redirect_to admins_employees_path, notice: 'Employee was successfully updated.'
        else
          render :edit, locals: { employee: employee }
        end
      elsif employee.update(employee_params)
        redirect_to admins_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit, locals: { employee: employee }
      end
    end

    private

    def employee
      @employee ||= Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:email, :number_of_available_kudos, :password)
    end
  end
end
