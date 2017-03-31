class RecreateGutsPermissionsAndAuthorizations < ActiveRecord::Migration[5.0]
  def change
    drop_table :guts_permissions
    drop_table :guts_authorizations

    create_table :guts_permissions do |t|
      t.string :resource
      t.string :grant
      t.references(
        :permissionable,
        polymorphic: true,
        index: { name: 'index_permissions_on_permissionable_type_and_permissionable' }
      )
      t.timestamps null: false
    end
  end
end
