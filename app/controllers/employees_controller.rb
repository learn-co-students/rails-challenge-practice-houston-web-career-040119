class EmployeesController < ApplicationController
  def create
    @employee = Employee.create(employee_params)
    @employee.company_id = params["company_id"].to_i

    if @employee.valid?  
      @employee.save
      redirect_to @employee.company
    else
      flash[:errors] = @employee.errors.full_messages
      redirect_to Company.find(params["company_id"].to_i)
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @company = @employee.company
    @employee.destroy
    redirect_to @company
  end

  def employee_params
    params.require(:employee).permit(:name,:title)
  end
end
