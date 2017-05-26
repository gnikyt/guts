class CreateGutsUserGroups < ActiveRecord::Migration[4.2]
  def change
    create_table :guts_user_groups do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
