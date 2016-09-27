# Namespace Guts tasks
namespace :guts do
  # Namespace Guts User tasks
  namespace :user do
    desc 'Create a user'
    task :create, [:name, :email, :password] => :environment do |_, args|
      if args.to_hash.size < 3
        raise ArgumentError, '[Guts] Please enter name, email, and a password'
      end

      user                       = Guts::User.new
      user.name                  = args[:name]
      user.password              = args[:password]
      user.password_confirmation = args[:password]
      user.email                 = args[:email]
      user.save!

      puts '[Guts] User created'
    end

    desc 'Delete a user'
    task :delete, [:email] => :environment do |_, args|
      raise ArgumentError, '[Guts] Please enter an email' if args.to_hash.empty?

      user = Guts::User.find_by(email: args[:email])
      raise StandardError, '[Guts] User not found' unless user

      user.destroy!

      puts '[Guts] User destroyed'
    end

    desc 'New password for a user'
    task :new_password, [:email, :password] => :environment do |_, args|
      if args.to_hash.size < 2
        raise ArgumentError, '[Guts] Please enter a password and an email'
      end

      user = Guts::User.find_by(email: args[:email])
      raise StandardError, '[Guts] User not found' unless user

      user.password              = args[:password]
      user.password_confirmation = args[:password]
      user.save!

      puts '[Guts] New password for user has been set'
    end

    desc 'Sets user as the main master for the admin panel'
    task :set_master, [:email] => :environment do |_, args|
      if args.to_hash.size < 1
        raise ArgumentError, '[Guts] Please enter an email'
      end

      user = Guts::User.find_by(email: args[:email])
      raise StandardError, '[Guts] User not found' unless user

      authorization = Guts::Authorization.find_by(subject_class: 'all')
      raise StandardError, '[Guts] Authorization entry for "all" not found, have you ran authorization seeding?' unless authorization

      user.permissions.build(authorization: authorization)
      user.save!

      puts '[Guts] User is now authorized for everything'
    end
  end
end
