module Guts
  # Extension generator
  class ExtensionGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    remove_class_option :skip_namespace

    class_option :authors,
                 type: :array,
                 default: [],
                 required: false,
                 desc: 'Indicates authors of this extension'

    def create_extension
      say 'Generating Guts Extension', Color::BLUE
      say display_extension_naming

      if yes? 'Would you like to continue? [y/n]', Color::YELLOW
        all_templates.each do |tpl|
          template tpl, extension_path_for(tpl)
        end
      end
    end

    private

    def extension_name
      @extension_name ||= singular_name
    end

    def extension_authors
      @extension_authors ||= options[:authors].presence
    end

    def extension_class_name
      @extension_class_name ||= extension_name.camelize
    end

    def extension_plural_class_name
      @extension_plural_class_name ||= extension_class_name.pluralize
    end

    def extension_plural_name
      @extension_plural_name ||= extension_name.pluralize
    end

    def destination_pathname
      @destination_pathname ||= Pathname.new self.destination_root.to_s
    end

    def extension_pathname
      destination_pathname.join 'vendor', 'extensions', extension_plural_name
    end

    def source_pathname
      @source_pathname ||= Pathname.new self.class.source_root.to_s
    end

    def all_templates
      Pathname.glob source_pathname.join('**', '**')
    end

    def extension_path_for(path)
      path = extension_pathname.join path.sub(%r{#{source_pathname}/?}, '')
      path = substitute_path_placeholders path

      path
    end

    def substitute_path_placeholders(path)
      Pathname.new path.to_s.gsub('extension_plural_name', extension_plural_name).
                             gsub('plural_name', plural_name).
                             gsub('singular_name', singular_name)
    end

    def display_extension_naming
      %(\t#{Color::GREEN}Name:#{Color::CLEAR} #{extension_name}
\t#{Color::GREEN}Name (Plural):#{Color::CLEAR} #{extension_plural_name}
\t#{Color::GREEN}Class Name:#{Color::CLEAR} #{extension_class_name}
\t#{Color::GREEN}Class Name (Plural):#{Color::CLEAR} #{extension_plural_class_name}
\t#{Color::GREEN}Path:#{Color::CLEAR} #{extension_pathname.to_s}
)
    end
  end
end
