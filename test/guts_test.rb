require 'test_helper'

class GutsTest < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, Guts
  end
  
  test 'should return version' do
    assert_not_nil Guts::VERSION
  end
  
  test 'should set configuration by assignment' do
    Guts.configuration.assignment_test = true
    assert_equal true, Guts.configuration.assignment_test
  end
  
  test 'should return nil for unassigned config' do
    assert_nil Guts.configuration.assignment_test_two
  end
  
  test 'should set configuration by block' do
    Guts.configure do |config|
      config.cat = 'Cat'
      config.dog = 'Dog'
    end
    
    assert_equal 'Cat', Guts.configuration.cat
    assert_equal 'Dog', Guts.configuration.dog
  end
  
  test 'config should be overrideable' do
    original_groups                 = Guts.configuration.admin_groups
    Guts.configuration.admin_groups = %w[Changed To More Admins]
    assert_not_equal Guts.configuration.admin_groups, original_groups
  end
  
  test 'should grab decorators in app' do
    assert $LOADED_FEATURES.join(',').include?('app/decorators/controllers/guts/type_decorator.rb')
    assert Guts::TypesController.instance_methods.include?(:explode)
  end
end
