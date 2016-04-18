class CreateGutsTrackers < ActiveRecord::Migration
  def change
    create_table :guts_trackers do |t|
      t.references :object, polymorphic: true, index: true
      t.text :params, null: true
      t.text :action

      t.timestamps null: false
    end
  end
end
