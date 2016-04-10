class CreateGutsUsers < ActiveRecord::Migration
  def change
    create_table :guts_users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :password_token, null: true

      t.timestamps null: false
    end
  end
end
