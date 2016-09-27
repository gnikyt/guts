class CreateGutsAssignments < ActiveRecord::Migration
  def change
    create_table :guts_assignments do |t|
      t.references :user
      t.references :permission

      t.timestamps null: false
    end
  end
end
