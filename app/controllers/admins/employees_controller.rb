module Admins
  class EmployeesController < AdminsController
    # GET /employees
    def index
      render :index, locals: { employees: Employee.all }
    end

    # GET /employees/1
    def show
      render :show, locals: { employee: employee }
    end

    # GET /employees/1/edit
    def edit
      render :edit, locals: { employee: employee }
    end

    # DELETE /employees/1
    def destroy
      employee.destroy
      redirect_to admins_employees_url, notice: 'Employee was successfully destroyed.'
    end

    # PATCH/PUT /employees/1
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

    # Use callbacks to share common setup or constraints between actions.
    def employee
      @employee ||= Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:email, :number_of_available_kudos, :password)
    end
  end
end
