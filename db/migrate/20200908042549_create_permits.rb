class CreatePermits < ActiveRecord::Migration[6.0]
  def change
    create_table :permits do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :location
      t.boolean :available
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
