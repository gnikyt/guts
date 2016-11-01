class CreateGutsPermissions < ActiveRecord::Migration
  def change
    create_table :guts_permissions do |t|
      t.references :permissionable, polymorphic: true, index: { name: 'index_perm_on_permissionable_type_and_permissionable' }
      t.references :authorization

      t.timestamps null: false
    end
  end
end
