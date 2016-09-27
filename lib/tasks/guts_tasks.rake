# Namespace Guts tasks
namespace :guts do
  # Namespace Guts DB tasks
  namespace :db do
    namespace :seed do
      desc 'Initial setup of Guts data'
      task all: :environment do
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

        Rake::Task['guts:db:seed:permissions'].invoke

        puts '[Guts] Database seeded'
      end

      desc 'Seed permissions based on all current controllers'
      task permissions: :environment do
        setup_permissions_for_controllers
      end
    end
  end
end

def setup_permissions_for_controllers
  write_permission('all', 'manage', 'Everything', 'All operations', true)

  controllers = Dir.new("#{Guts::Engine.root}/app/controllers/guts").entries
  controllers.each do |controller|
    if controller =~ /_controller/
      foo_bar = "Guts::#{controller.camelize.gsub('.rb','')}".constantize.new
    end
  end

  Guts::ApplicationController.subclasses.each do |controller|
    if controller.respond_to?(:permission)
      clazz, description = controller.permission

      write_permission(clazz, 'manage', description, 'All operations')

      controller.action_methods.each do |action|
        if action.to_s.index('_callback').nil?
          action_desc, cancan_action = eval_cancan_action(action)

          write_permission(clazz, cancan_action, description, action_desc)
        end
      end
    end
  end
end

def eval_cancan_action(action)
  case action.to_s
  when 'index', 'show', 'search'
    cancan_action = 'read'
    action_desc   = 'read'
  when 'create', 'new'
    cancan_action = 'create'
    action_desc   = 'create'
  when 'edit', 'update'
    cancan_action = 'update'
    action_desc   = 'edit'
  when 'delete', 'destroy'
    cancan_action = 'delete'
    action_desc   = 'delete'
  else
    cancan_action = action.to_s
    action_desc   = 'Other: ' << cancan_action
  end

  return action_desc, cancan_action
end

def write_permission(class_name, cancan_action, title, description, force_id_1 = false)
  permission = Guts::Permission.where('subject_class = ? and action = ?', class_name, cancan_action).first

  if not permission
    permission               = Guts::Permission.new
    permission.id            = 1 if force_id_1
    permission.subject_class = class_name
    permission.action        = cancan_action
    permission.title         = title
    permission.description   = description
    permission.save
  else
    permission.title       = title
    permission.description = description
    permission.save
  end
end
