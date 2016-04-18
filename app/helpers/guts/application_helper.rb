module Guts
  # Common helpers for the whole application
  module ApplicationHelper
    # Creates a wrapper around `link_to` to destroy objects
    # through javascript by creating a hidden form
    # @param [String] title the title to use for the link
    # @param [Object] object the object record to reference
    # @param [Hash] link_opts an extension of link_to's options
    # @return [String] html to display
    def link_to_destroy(title, object, link_opts = {})
      html = []
      html << link_to(title, '#', link_opts.merge(class: "destroy_resource #{link_opts[:class]}"))
      html << form_for(object, url: object, method: :delete, html: { style: 'display: none' }) {}
      
      html.join('').html_safe
    end
    
    # Creates a human-readable version of an object
    # @param [Object] object the object record to reference
    # @return [String] the result of conversion
    def sub_title_for(object)
      object.class.to_s.demodulize.underscore.titleize
    end
    
    # Simply creates an ID to use in the `body` of the layout
    # which is a combination of the current controller and action
    # @return [String] the ID
    # @example Types#edit
    #   Will produce `guts_types_edit`
    def controller_css_id
      "#{params[:controller].tr('/', '_')}_#{params[:action]}"
    end
    
    # Determines if a menu is active in the admin panel
    # @param [Symbol, String] key the string to compare against
    # @param [Boolean] strict weather to do a direct compare or sub string
    # @example Strict (default)
    #   For /guts/types... `menu_active? :types`
    # @example Non-strict
    #   For /guts/navigations/main-menu/item... `menu_active? :navigation, false`
    def menu_active?(key, strict = true)
      if strict
        controller.controller_name == key.to_s
      else
        controller.controller_name.include? key.to_s
      end
    end
    
    # Helper for settings the current site ID for a model in the form
    # @param [Object] f the current form object
    # @return [String] html for form field
    def current_site_form_field(f)
      f.hidden_field :site_id, value: @current_site.try(:id)
    end
  end
end
