class ChangeStatusStringBooking < ActiveRecord::Migration[6.0]
  def change
    change_column :bookings, :status, :string
  end
end
