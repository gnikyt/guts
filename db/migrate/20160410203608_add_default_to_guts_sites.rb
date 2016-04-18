class AddDefaultToGutsSites < ActiveRecord::Migration
  def change
    add_column :guts_sites, :default, :boolean, default: 0
  end
end
