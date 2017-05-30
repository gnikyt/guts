class CreateGutsOptions < ActiveRecord::Migration[4.2]
  def change
    create_table :guts_options do |t|
      t.string :key
      t.text :value, null: true
      
      t.timestamps null: false
    end
  end
end
