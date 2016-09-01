class AddSpecificAddressesToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :specific_addresses_specified, :boolean
  end
end
