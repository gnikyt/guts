# Namespace Guts tasks
namespace :guts do
  # Namespace Guts User tasks
  namespace :user do
    desc "Create a user"
    task :create, [:name, :email, :password, :is_admin] => :environment do |t, args|
      if args.to_hash.size < 3
        puts "Please enter name, email, and a password"
        exit
      end
      
      group = Guts::Group.find_by(title: Guts::Configuration.admin_groups[0])
      
      user                       = Guts::User.new
      user.name                  = args[:name]
      user.password              = args[:password]
      user.password_confirmation = args[:password]
      user.email                 = args[:email]
      user.groups << group if args[:is_admin] and group
      user.save!
      
      puts "[Guts] User #{args[:name]} created"
    end
    
    desc "Delete a user"
    task :delete, [:email] => :environment do |t, args|
      if args.to_hash.size === 0
        puts "Please enter an email"
        exit
      end
      
      user = Guts::User.find(email: args[:email])
      user.destroy!
      
      puts "[Guts] User destroyed"
    end
    
    desc "New password for a user"
    task :new_password, [:email, :password] => :environment do |t, args|
      if args.to_hash.size < 2
        puts "Please enter a password and an email"
        exit
      end
      
      user                       = Guts::User.find(email: args[:email])
      user.password              = args[:password]
      user.password_confirmation = args[:password]
      user.save!
      
      puts "[Guts] New password for user has been set"
    end
  end
end
