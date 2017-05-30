class CreateGutsAuthorizations < ActiveRecord::Migration[4.2]
  def change
    create_table :guts_authorizations do |t|
      t.string :title
      t.string :subject_class
      t.integer :subject_id
      t.string :action
      t.text :description

      t.timestamps null: false
    end
  end
end
