class AddCoordinatesToPermits < ActiveRecord::Migration[6.0]
  def change
    add_column :permits, :latitude, :float
    add_column :permits, :longitude, :float
  end
end
