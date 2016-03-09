require "test_helper"

module Guts
  class UsersTaskTest < ActiveSupport::TestCase
    setup do
      Rake::Task.define_task :environment
      Guts::Engine.load_tasks
    end
    
    teardown do
      Rake::Task.clear
    end
    
    test "user should be created" do
      out, err = capture_io do
        Rake::Task["guts:user:create"].invoke("Tom Jones", "tom.jones@gmail.com", "password", true)
      end
      
      assert_equal "[Guts] User created", out.chomp
    end
    
    test "user should not be created when missing information" do
      exception = assert_raises StandardError do
        capture_io do
          Rake::Task["guts:user:create"].invoke("Tom Jones", "tom.jones@gmail.com")
        end
      end
      
      assert_match "[Guts] Please enter name, email, and a password", exception.message
    end
    
    test "user should be deleted" do
      out, err = capture_io do
        Rake::Task["guts:user:create"].invoke("Tom Joneser", "tom.joneser@gmail.com", "password", true)
        Rake::Task["guts:user:delete"].invoke("tom.joneser@gmail.com")
      end
      
      assert_match /User destroyed/, out.chomp
    end
    
    test "user should not be deleted if missing information" do
      exception = assert_raises ArgumentError do
        capture_io do
          Rake::Task["guts:user:delete"].invoke
        end
      end
      
      assert_equal "[Guts] Please enter an email", exception.message
    end
    
    test "user should not be deleted if they dont exist" do
      exception = assert_raises StandardError do
        capture_io do
          Rake::Task["guts:user:delete"].invoke("timmy.kimble@gmail.com")
        end
      end
      
      assert_equal "[Guts] User not found", exception.message
    end
    
    test "should set new password for user" do
      out, err = capture_io do
        Rake::Task["guts:user:create"].invoke("Tom Jonesed", "tom.jonesed@gmail.com", "password", true)
        Rake::Task["guts:user:new_password"].invoke("tom.jonesed@gmail.com", "password_2")
      end
      
      assert_match /New password/, out.chomp
    end
    
    test "should not set new password for user if they dont exist" do
      exception = assert_raises StandardError do
        capture_io do
          Rake::Task["guts:user:new_password"].invoke("timmy.kimble@gmail.com", "password_2")
        end
      end
      
      assert_equal "[Guts] User not found", exception.message
    end
    
    test "should not set password for user if missing information" do
      exception = assert_raises ArgumentError do
        capture_io do
          Rake::Task["guts:user:new_password"].invoke
        end
      end
      
      assert_equal "[Guts] Please enter a password and an email", exception.message
    end
  end
end