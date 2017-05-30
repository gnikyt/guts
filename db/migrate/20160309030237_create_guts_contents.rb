class CreateGutsContents < ActiveRecord::Migration[4.2]
  def change
    create_table :guts_contents do |t|
      t.string :title
      t.string :slug
      t.text :tags, null: true
      t.text :content, null: true
      t.integer :visible, default: 1, limit: 1
      t.references :type
      t.references :user

      t.timestamps null: false
    end

    add_index :guts_contents, :slug, unique: true
  end
end
