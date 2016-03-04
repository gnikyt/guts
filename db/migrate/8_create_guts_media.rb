class CreateGutsMedia < ActiveRecord::Migration
  def change
    create_table :guts_media do |t|
      t.string :title
      t.text :tags, null: true
      t.integer :position, default: 0, null: true
      t.references :filable, polymorphic: true, index: true
      t.string :caption, null: true

      t.timestamps null: false
    end
    
    add_attachment :guts_media, :file
  end
end
