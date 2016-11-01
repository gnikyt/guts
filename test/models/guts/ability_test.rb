require 'test_helper'

module Guts
  class AbilityTest < ActiveSupport::TestCase
    test 'should get subject class for guts models' do
      ability = Guts::Ability.new nil
      result  = ability.send :subject_class, 'Guts::Type'

      assert_instance_of Class, result
    end

    test 'should get symbol for non-guts models' do
      ability = Guts::Ability.new nil
      result  = ability.send :subject_class, 'all'

      assert_instance_of Symbol, result
    end
  end
end
