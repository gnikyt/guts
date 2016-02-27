class CreateGutsMetafields < ActiveRecord::Migration
  def change
    create_table :guts_metafields do |t|
      t.string :key
      t.text :value
      t.references :fieldable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
