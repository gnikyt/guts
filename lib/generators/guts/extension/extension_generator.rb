module Guts
  # Extension generator
  # This generator has code based upon RefinaryCMS' generator
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
      check_extension_path
      write_templates
      append_to_gemfile
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
      destination_pathname.join 'vendor', 'extensions', "guts-#{extension_plural_name}"
    end

    def source_pathname
      @source_pathname ||= Pathname.new self.class.source_root.to_s
    end

    def gem_name
      "guts-#{extension_name}"
    end

    def gemfile
      @gemfile ||= begin
        Bundler.default_gemfile || destination_pathname.join('Gemfile')
      end
    end

    def extension_in_gemfile?
      gemfile.read.scan(%r{#{gem_name}}).any?
    end

    def append_to_gemfile
      unless Rails.env.test? || extension_in_gemfile?
        path = extension_pathname.parent.relative_path_from(gemfile.parent)
        append_file gemfile, "\ngem '#{gem_name}', path: '#{path}'"
      end
    end

    def all_templates
      Pathname.glob source_pathname.join('**', '**')
    end

    def write_templates
      all_templates.each do |tpl|
        if tpl.directory?
          FileUtils::mkdir_p extension_path_for(tpl)
        else
          template tpl, extension_path_for(tpl)
        end
      end
    end

    def substitute_path_placeholders(path)
      Pathname.new path.to_s.gsub('extension_plural_name', extension_plural_name).
                             gsub('plural_name', plural_name).
                             gsub('singular_name', singular_name)
    end

    def extension_path_for(path)
      path = extension_pathname.join path.sub(%r{#{source_pathname}/?}, '')
      path = substitute_path_placeholders path

      path
    end

    def display_extension_naming
      %(#{Color::GREEN}Name:#{Color::CLEAR} #{extension_name}
#{Color::GREEN}Name (Plural):#{Color::CLEAR} #{extension_plural_name}
#{Color::GREEN}Class Name:#{Color::CLEAR} #{extension_class_name}
#{Color::GREEN}Class Name (Plural):#{Color::CLEAR} #{extension_plural_class_name}
#{Color::GREEN}Path:#{Color::CLEAR} #{extension_pathname.to_s}
)
    end

    def check_extension_path
      abort "#{Color::RED}Error: An extension already exists in that path#{Color::CLEAR}" if extension_pathname.directory?
    end
  end
end
