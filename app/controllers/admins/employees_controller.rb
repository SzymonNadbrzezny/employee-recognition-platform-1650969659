module Admins
  class EmployeesController < AdminsController
    # GET /employees
    def index
      @employees = Employee.all
    end

    # GET /employees/1
    def show
      current_employee
    end

    # GET /employees/1/edit
    def edit
      current_employee
    end

    # DELETE /employees/1
    def destroy
      current_employee
      @employee.destroy
      redirect_to admins_employees_url, notice: 'Employee was successfully destroyed.'
    end

    # PATCH/PUT /employees/1
    def update
      current_employee
      if employee_params[:password] != ''
        if @employee.update(employee_params)
          redirect_to admins_employees_path, notice: 'Employee was successfully updated.'
        else
          render :edit
        end
      elsif @employee.update_without_password(employee_params.except(:password))
        redirect_to admins_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def current_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:email, :number_of_available_kudos, :password)
    end
  end
end
