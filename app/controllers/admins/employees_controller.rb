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

    def add_kudos_form
      render :add_kudos_form
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

    def add_kudos
      kudos_to_add = add_kudos_params[:number_of_kudos_to_add].to_i
      if kudos_to_add.between?(1, 20)
        Employee.transaction do
          Employee.find_each do |employee|
            employee.increment(:number_of_available_kudos, kudos_to_add).save!
          end
        rescue ActiveRecord::RecordNotSaved
          flash[:alert] = 'Error occured. No kudos were added. Please try again later.'
          raise ActiveRecord::Rollback
        else
          flash[:notice] = 'Kudos were added successfuly.'
        end
        redirect_to admins_employees_path
      else
        redirect_to add_kudos_form_admins_employees, notice: 'Number of kudos to add must be between 1 and 20.'
      end
    end

    private

    def employee
      @employee ||= Employee.find(params[:id])
    end

    def add_kudos_params
      params.permit(:authenticity_token, :number_of_kudos_to_add)
    end

    def employee_params
      params.require(:employee).permit(:email, :number_of_available_kudos, :password)
    end
  end
end
