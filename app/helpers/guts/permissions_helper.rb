module Guts
  # Permissions helper
  module PermissionsHelper
    # Removes Guts from the authorization string to pretty it
    # @param [String] item the item to clean
    # @return [String] the cleaned string
    def clean_subject_class(item)
      item.gsub(/Guts::/, '').titleize
    end
  end
end
