class CreateGutsContents < ActiveRecord::Migration
  def change
    create_table :guts_contents do |t|
      t.string :title
      t.string :slug
      t.text :tags, null: true
      t.text :content, null: true
      t.integer :visible, default: 1, limit: 1

      t.timestamps null: false
    end
    
    add_index :guts_contents, :slug, unique: true
    add_reference :guts_contents, :type, index: true, foreign_key: true
    add_reference :guts_contents, :user, index: true, foreign_key: true, null: true
  end
end
