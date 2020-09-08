class PermitsController < ApplicationController
  def index
    @permits = Permit.all
  end

  def show
    @permit = Permit.find(params[:id])
  end

  def new
    @permit = Permit.new
  end

  def create
    @permit = Permit.new(permit_params)

    if @permit.save
      redirect_to @permit, notice: "Permit was successfully listed!"
    else
      render :new
    end
  end

  def destroy
    @permit = Permit.find(params[:id])
    @permit.destroy
    redirect_to @permit, notice: "Permit was successfully deleted."
  end

  private

  def set_permit
    @permit = Permit.find(params[:id])
  end

  def permit_params
    params.require(:permit).permit(:name, :description, :price, :location, :available, :user_id)
  end

end
