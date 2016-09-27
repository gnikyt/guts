class CreateGutsPermissions < ActiveRecord::Migration
  def change
    create_table :guts_permissions do |t|
      t.string :title
      t.string :subject_class
      t.integer :subject_id
      t.string :action
      t.text :description

      t.timestamps null: false
    end
  end
end
