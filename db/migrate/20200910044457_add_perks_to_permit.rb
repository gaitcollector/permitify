class AddPerksToPermit < ActiveRecord::Migration[6.0]
  def change
    add_column :permits, :perks, :string, array: true, default: []
  end
end
