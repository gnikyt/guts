class RemoveGutsTrackerTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :guts_trackers
  end
end
