class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :tdms_id
      t.string :type
      t.string :provider
      t.float :fare
      t.float :tip
      t.float :surcharge
      t.float :extras
      t.float :tolls
      t.float :total
      t.string :payment_type
      t.string :payment_provider
      t.date :start_date
      t.datetime :pickup_time
      t.datetime :dropoff_time
      t.decimal :pickup_lat
      t.decimal :pickup_long
      t.string :pickup_address
      t.string :pickup_city
      t.string :pickup_state
      t.string :pickup_postcode
      t.decimal :dropoff_lat
      t.decimal :dropoff_lon
      t.string :dropoff_address
      t.string :dropoff_city
      t.string :dropoff_state
      t.string :dropoff_postcode
      t.float :mileage
      t.integer :time
      t.decimal :northeast_bound_lat
      t.decimal :northeast_bound_long
      t.decimal :southeast_bound_lat
      t.decimal :southeast_bound_lon
      t.test :polyline

      t.timestamps
    end
  end
end
