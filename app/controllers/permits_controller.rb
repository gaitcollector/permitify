class PermitsController < ApplicationController
  def index
    @permits = Permit.all

    @markers = @permits.geocoded.map do |permit|
      {
        lat: permit.latitude,
        lng: permit.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { permit: permit }),
      }
    end
  end

  def show
    @permit = Permit.find(params[:id])
  end

  def new
    @permit = Permit.new
  end

  def create
    @permit = Permit.new(permit_params)
    @permit.user = current_user

    if @permit.save
      redirect_to @permit, notice: "Permit was successfully listed!"
    else
      render :new
    end
  end

  def edit
    @permit = Permit.find(params[:id])
  end

  def update
    # if @permit.user = current_user
      @permit = Permit.find(params[:id])
      if @permit.update(permit_params)
        redirect_to @permit, notice: "Permit was successfully updated!"
      else
        render :edit
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
    params.require(:permit).permit(:name, :description, :price, :location, :available, :photo)
  end

end
