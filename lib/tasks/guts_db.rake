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

        Rake::Task['guts:db:seed:authorizations'].invoke

        puts '[Guts] Database seeded'
      end

      desc 'Seed authorization rules based on all current controllers'
      task authorizations: :environment do
        load_controllers
        setup_authorizations_for_controllers

        puts '[Guts] Authorizations seeded'
      end
    end
  end
end

def load_controllers
  controllers = Dir.new("#{Guts::Engine.root}/app/controllers/guts").entries

  controllers.select do |controller|
    controller =~ /_controller/
  end.each do |controller|
    foo_bar = "Guts::#{controller.camelize.gsub('.rb', '')}".constantize.new
  end
end

def bad_action?(action)
  bad_actions = %w(_callback with_current_site current_site)
  bad_actions.any? { |name| action.include? name }
end

def setup_authorizations_for_controllers
  write_permission 'all', 'manage', 'Everything', 'All operations'

  Guts::ApplicationController.subclasses.each do |controller|
    next unless controller.respond_to?(:permission)

    clazz, description = controller.permission
    write_permission clazz, 'manage', description, 'All operations'

    controller.action_methods.each do |action|
      next if bad_action?(action)

      action_desc, cancan_action = eval_cancan_action(action)
      write_permission clazz, cancan_action, description, action_desc
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

  [action_desc, cancan_action]
end

def write_permission(class_name, cancan_action, title, description)
  permission = Guts::Authorization.where('subject_class = ? and action = ?', class_name, cancan_action).first

  if permission.nil?
    permission               = Guts::Authorization.new
    permission.subject_class = class_name
    permission.action        = cancan_action
  end

  permission.title       = title
  permission.description = description
  permission.save
end
