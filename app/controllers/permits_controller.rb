class PermitsController < ApplicationController
  def index
        if params[:query].present?
      sql_query = " \
        permits.name @@ :query \
        OR permits.description @@ :query \
        OR permits.location @@ :query \
        OR permits.perks @@ :query
      "
      @permits = Permit.search_by_perks(params[:query])

    else
      @permits = Permit.all
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
    params.require(:permit).permit(:name, :description, :perks, :price, :location, :available, :photo)
  end

end
