class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
    @employee = Employee.new
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.assign_attributes(company_params)
    if @company.valid?
      @company.save
      assign_offices
      redirect_to @company
    else
      flash[:errors] = @company.errors.full_messages
      redirect_to new_company_path(@company)
    end
  end

  def index
    @companies = Company.all
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def assign_offices
    Building.all.each do |building|
      building.empty_offices.each do |office|
        if params["building_#{building.id}_floor_#{office.floor}"]
          Office.create(building_id:building.id, company_id: @company.id, floor: office.floor )
        end
      end
    end
  end

end