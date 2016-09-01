class AddProcessedToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :processed, :boolean
  end
end
