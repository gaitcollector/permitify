class DashboardsController < ApplicationController
  def show
    @bookings = Booking.where(user: current_user)
    @requests = Booking.all.select {|booking| booking.permit.user == current_user }
  end
end
