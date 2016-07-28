require 'test_helper'

class GutsExtensionRegistry < ActiveSupport::TestCase
  test 'registry has extensions array' do
    assert_instance_of Array, Guts::ExtensionRegistry.extensions
  end

  test 'extension can register' do
    e_name  = 'Homebrews'
    e_menus = [{ 'List': '/admin/homebrews/' }]

    Guts::ExtensionRegistry.register do |e|
      e.name  = e_name
      e.menus = e_menus
    end

    assert_equal 1, Guts::ExtensionRegistry.extensions.size
    assert_equal e_name, Guts::ExtensionRegistry.extensions[0].name
    assert_equal e_menus, Guts::ExtensionRegistry.extensions[0].menus
  end
end
