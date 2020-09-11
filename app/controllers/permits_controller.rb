class PermitsController < ApplicationController
  def index

    if params[:query].present?
      sql_query = "permits.perks @@ :query"
      @permits = Permit.search_by_perks(params[:query])

    else
      @permits = Permit.all
    end

    @markers = @permits.geocoded.map do |permit|
      {
        lat: permit.latitude,
        lng: permit.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { permit: permit })
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
    params[:permit][:perks].each {|perk| @permit.perks << perk }

    @permit.user = current_user
    respond_to do |format|
      if @permit.save
        format.html { redirect_to @permit, notice: 'Permit was successfully listed!' }
        format.json { render :show, status: :created, location: @permit }
      else
        format.html { render :new }
        format.json { render json: @permit.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    @permit = Permit.find(params[:id])
  end

  def update
    @permit = Permit.find(params[:id])
    @permit.user = current_user
    params[:permit][:perks].each {|perk| @permit.perks << perk }
    respond_to do |format|
      if @permit.update(permit_params)
        format.html { redirect_to @permit, notice: 'Permit was successfully updated!' }
        format.json { render :show, status: :ok, location: @permit }
      else
        format.html { render :edit }
        format.json { render json: @permit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @permit = Permit.find(params[:id])
    @permit.destroy
    respond_to do |format|
      format.html { redirect_to @permit, notice: 'Permit was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private

  def set_permit
    @permit = Permit.find(params[:id])
  end

  def permit_params
    params.require(:permit).permit(:name, :description, :perks, :price, :location, :available, :photo)
  end

end
