class BuildingsController < ApplicationController
  def show
    @building = Building.find(params[:id])
  end

  def index
    @buildings = Building.all
  end

  def edit
    @building = Building.find(params[:id])
  end

  def update
    @building = Building.find(params[:id])
    @building.assign_attributes(building_params)
    if @building.valid?
      @building.save
      redirect_to @building
    else
      flash[:errors] = @building.errors.full_messages
      redirect_to edit_building_path(@building)
    end
  end

  private

  def building_params
    params.require(:building).permit(:name,:country,:address,:rent_per_floor,:number_of_floors)
  end
end