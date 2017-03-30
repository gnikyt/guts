module Guts
  # Model concern for permissionable models
  module GrantedConcern
    extend ActiveSupport::Concern

    included do
      # Determines if a user has permission to a resource and type
      # @param [Symbol|String|Class|Array] resource the resource to use
      # @param [Symbol|String] method the method for the resource
      # @return [Boolean] if user has access to resource and method
      def granted?(resource, method)
        grants = permissions.where(resource: grant_resource_string(resource)).pluck(:grant)
        grants.include? method.to_s
      end
      
      private

      # Generates a resource string from input
      # @param [Symbol|String|Class|Array] resource the resource to use
      # @return [String] the compiled resource string
      def grant_resource_string(resource)
        if resource.is_a?(Array)
          resource.map { |bit| grant_class_name bit }.join('::')
        else
          grant_class_name resource
        end
      end

      # Determines the class name
      # @param [Symbol|String|Class|Array] subject the subject to parse
      # @return [String] the class name
      # @note This is from Pundit's finder
      def grant_class_name(subject)
        if subject.respond_to?(:model_name)
          subject.model_name
        elsif subject.is_a?(Symbol)
          subject.to_s.camelize
        elsif subject.is_a?(Class)
          subject
        else
          subject.class
        end
      end
    end
  end
end
