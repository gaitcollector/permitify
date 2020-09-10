class BookingsController < ApplicationController
before_action :set_booking, only: [:show, :edit, :update, :destroy]
  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
    @permit = Permit.find(params[:permit_id])
  end

  def edit
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.permit = Permit.find(params[:permit_id])
    @booking.total_price = calculated_price
    @booking.status = "Booked"

    if @booking.save
      redirect_to dashboard_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to dashboard_url, notice: 'Booking was successfully deleted.'
  end

  def calculated_price
    (@booking.permit.price * ( @booking.end_date - @booking.start_date )).to_i
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:total_price, :start_date, :end_date, :status)
  end
end
