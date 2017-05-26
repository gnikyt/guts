# Upgrade to scoped slugs
class RemoveUniqueSlugConstraint < ActiveRecord::Migration[4.2]
  def change
    # Categories
    remove_index :guts_categories, :slug
    add_index :guts_categories, :slug

    # Content
    remove_index :guts_contents, :slug
    add_index :guts_contents, :slug

    # Navigations
    remove_index :guts_navigations, :slug
    add_index :guts_navigations, :slug

    # Types
    remove_index :guts_types, :slug
    add_index :guts_types, :slug
  end
end
