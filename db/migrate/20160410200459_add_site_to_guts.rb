class AddSiteToGuts < ActiveRecord::Migration
  def change
    tables = [
      :guts_types,
      :guts_categories,
      :guts_contents,
      :guts_navigations,
      :guts_navigation_items,
      :guts_metafields,
      :guts_trackers,
      :guts_options,
      :guts_media
    ]
    
    tables.each do |table|
      change_table table do |t|
        t.references :site, index: true
      end
    end
  end
end
