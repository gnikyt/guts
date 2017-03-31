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

    test 'test_1' do
      out, = capture_io do
        Rake::Task['guts:db:seed:all'].invoke
      end

      assert_equal '[Guts] Database seeded', out.chomp
    end
  end
end
