class CreateGutsNavigationItems < ActiveRecord::Migration
  def change
    create_table :guts_navigation_items do |t|
      t.string :title
      t.string :custom
      t.integer :position, default: 0, null: true
      t.references :navigatable, polymorphic: true, index: {name: "index_nav_items_on_nav_with_type_and_id"}

      t.timestamps null: false
    end
    
    add_reference :guts_navigation_items, :navigation, index: true, foreign_key: true
  end
end
