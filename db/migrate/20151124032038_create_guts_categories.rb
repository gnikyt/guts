class CreateGutsCategories < ActiveRecord::Migration
  def change
    create_table :guts_categories do |t|
      t.string :title
      t.string :slug
      t.text :metafields, null: true
      
      t.timestamps null: false
    end
    
    add_index :guts_categories, :slug, unique: true
  end
end
