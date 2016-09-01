class AddMappableToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :mappable, :boolean
  end
end
