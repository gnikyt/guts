class AddSiteToGuts < ActiveRecord::Migration
  def change
    add_reference :guts_types, :site, index: true, foreign_key: true
    add_reference :guts_categories, :site, index: true, foreign_key: true
    add_reference :guts_contents, :site, index: true, foreign_key: true
    add_reference :guts_navigations, :site, index: true, foreign_key: true
    add_reference :guts_navigation_items, :site, index: true, foreign_key: true
    add_reference :guts_metafields, :site, index: true, foreign_key: true
    add_reference :guts_trackers, :site, index: true, foreign_key: true
    add_reference :guts_options, :site, index: true, foreign_key: true
    add_reference :guts_media, :site, index: true, foreign_key: true
  end
end
