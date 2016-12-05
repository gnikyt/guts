# Guts' module namespace
module Guts
  # Configuration for Guts
  # @return [Object] returns configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Defining configuration through block format
  # @yield [configuration] passes current configuration into block
  def self.configure
    yield configuration
  end

  # Configuration class for Guts
  class Configuration
    # Getter and setter method for configuration
    # so that there is not a set amount of configs
    # @param [String] name the config name
    # @param [Array] args list of args (used for setting)
    # @return the configuration requested
    def method_missing(name, *args)
      name = name.to_s

      if name =~ /=$/
        instance_variable_set "@#{name.chop}", args.first
      else
        instance_variable_get "@#{name}"
      end
    end
  end
end
