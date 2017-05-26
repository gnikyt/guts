class AddDefaultToGutsSites < ActiveRecord::Migration[4.2]
  def change
    add_column :guts_sites, :default, :boolean, default: false
  end
end
