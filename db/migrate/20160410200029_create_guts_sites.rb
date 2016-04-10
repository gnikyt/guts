class CreateGutsSites < ActiveRecord::Migration
  def change
    create_table :guts_sites do |t|
      t.string :name
      t.string :domain

      t.timestamps null: false
    end
  end
end
