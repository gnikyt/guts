require 'test_helper'

module Guts
  class DbTaskTest < ActiveSupport::TestCase
    def self.test_order
      :alpha
    end
    
    setup do
      Rake::Task.define_task :environment
      Guts::Engine.load_tasks
    end

    teardown do
      Rake::Task.clear
    end

    # Unordered tests produces bad coverage results
    test 'test_1' do
      controllers = load_controllers

      assert_instance_of Array, controllers
      assert_includes controllers, 'application_controller.rb'
    end

    test 'test_2' do
      out, = capture_io do
        Rake::Task['guts:db:seed:authorizations'].invoke
      end

      assert_equal '[Guts] Authorizations seeded', out.chomp
    end

    test 'test_3' do
      out, = capture_io do
        Rake::Task['guts:db:seed:all'].invoke
      end

      assert_equal "[Guts] Authorizations seeded\n[Guts] Database seeded", out.chomp
    end
  end
end
