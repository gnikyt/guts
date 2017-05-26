class CreateGutsTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :guts_types do |t|
      t.string :title
      t.string :slug

      t.timestamps null: false
    end
    add_index :guts_types, :slug, unique: true
  end
end
