module Guts
  # Permissions helper
  module PermissionsHelper
    def clean_subject_class(item)
      item.gsub(/Guts::/, '').titleize
    end
  end
end
