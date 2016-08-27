class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :distance
      t.integer :duration
      t.decimal :start_lat
      t.decimal :start_lon
      t.decimal :end_lat
      t.decimal :end_lon
      t.string :instructions
      t.text :polyline

      t.timestamps
    end
  end
end
