# Namespace Guts tasks
namespace :guts do
  # Namespace Guts DB tasks
  namespace :db do
    desc 'Initial setup of Guts data'
    task seed: :environment do
      type       = Guts::Type.new
      type.title = 'Page'
      type.slug  = 'page'
      type.save!
      
      type       = Guts::Type.new
      type.title = 'Post'
      type.slug  = 'post'
      type.save!
      
      category       = Guts::Category.new
      category.title = 'Uncategorized'
      category.slug  = 'uncategorized'
      category.save!
      
      group       = Guts::Group.new
      group.title = 'Admins'
      group.slug  = 'admins'
      group.save!
      
      puts '[Guts] Database seeded'
    end
  end
end
