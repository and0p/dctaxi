class AddTripIdToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :trip_id, :integer
  end
end
