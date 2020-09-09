class DashboardsController < ApplicationController
  def show
    @bookings = Booking.all
  end
end
