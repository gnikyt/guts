module Guts
  # Extension generator
  # This generator has code based upon RefinaryCMS' generator
  class ExtensionGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    # Removes namespace option
    remove_class_option :skip_namespace

    # For setting author names to Gemspec file
    class_option :authors,
                 type: :array,
                 default: [],
                 required: false,
                 desc: 'Indicates authors of this extension'

    # For setting author emails to Gemspec file
    class_option :author_emails,
                 type: :array,
                 default: [],
                 required: false,
                 desc: 'Indicates emails for the authors of this extension'

    # For setting license to Gemspec file
    class_option :license,
                 type: :string,
                 default: 'MIT',
                 required: false,
                 desc: 'Indicates license of this extension'

    # Public method which when invoked, will run the nessessary
    # steps to create the extension
    def create_extension
      # Display the extension naming
      say 'Generating Guts Extension', Color::BLUE
      say display_extension_naming

      # Checks if extension is existing (so we don't overwrite it)
      check_extension_path

      # Writes the files and directories to the destination path
      # See `extension_pathname`
      write_templates

      # Adds the extension to the parent app's Gemfile
      append_to_gemfile
    end

    private

    # Extension's name
    # @return [String] extension's singular name
    def extension_name
      @extension_name ||= singular_name
    end

    # Extension's author names
    # @return [Array] extension's authors names for Gemfile
    def extension_authors
      @extension_authors ||= options[:authors].presence
    end

    # Extension's author emails
    # @return [Array] extension's author emails for Gemfile
    def extension_author_emails
      @extension_author_emails ||= options[:author_emails].presence
    end

    # Extension's license
    # @return [String] extension's license for Gemfile
    def extension_license
      @extension_license ||= options[:license].presence
    end

    # Extension's class name based on extension name
    # @return [String] the class name for extension
    def extension_class_name
      @extension_class_name ||= extension_name.camelize
    end

    # Extension's class name (plural) based on extension name
    # @return [String] the class name (plural) for extension
    def extension_plural_class_name
      @extension_plural_class_name ||= extension_class_name.pluralize
    end

    # Extension's name (plural) based on extension name
    # @return [String] the name (plural) for extension
    def extension_plural_name
      @extension_plural_name ||= extension_name.pluralize
    end

    # Extension's destination path
    # @return [Object] the Pathname value for the destination
    def destination_pathname
      @destination_pathname ||= Pathname.new self.destination_root.to_s
    end

    # Extension's destination path. Where the extension files will end up
    # @return [String] the destination path
    def extension_pathname
      destination_pathname.join 'vendor', 'extensions', "guts-#{extension_plural_name}"
    end

    # Extension's source for the template files
    # @return [Object] the Pathname for templates
    def source_pathname
      @source_pathname ||= Pathname.new self.class.source_root.to_s
    end

    # Extension's Gem name based on extension name
    # @return [String] the Gem name
    def gem_name
      "guts-#{extension_name}"
    end

    # Locates the Gemfile for the Rails app
    # @return [Object] Pathname for Gemfile
    def gemfile
      @gemfile ||= begin
        Bundler.default_gemfile || destination_pathname.join('Gemfile')
      end
    end

    # Checks if the extension is already listed in the Gemfile
    # @return [Boolean] exists in Gemile or not
    def extension_in_gemfile?
      gemfile.read.scan(%r{/#{gem_name}/}).any?
    end

    # Appends the Gem name into the Gemfile for the Rails app
    def append_to_gemfile
      unless Rails.env.test? || extension_in_gemfile?
        path = extension_pathname.parent.relative_path_from(gemfile.parent)
        append_file gemfile, "\ngem '#{gem_name}', path: '#{path}'"
      end
    end

    # Gets a glob of all source templates
    # @return [Object] Pathname globs for templates
    def all_templates
      Pathname.glob source_pathname.join('**', '**')
    end

    # Does the actual writing/coping/moving of files and directories
    # From source templates to extension destination
    def write_templates
      all_templates.each do |tpl|
        if tpl.directory?
          FileUtils.mkdir_p extension_path_for(tpl)
        else
          template tpl, extension_path_for(tpl)
        end
      end
    end

    # Replaces values in directory or file names with extension values
    # @param [Object] path the Pathname for the template
    # @return [Object] parsed Pathname for template with replacements
    def substitute_path_placeholders(path)
      Pathname.new path.to_s
        .gsub('extension_plural_name', extension_plural_name)
        .gsub('extension_plural_class_name', extension_plural_class_name)
        .gsub('plural_name', plural_name)
        .gsub('singular_name', singular_name)
    end

    # Gets the extension path for a template and replaces values
    # @param [Object] path the path
    # @return [Object] completed Pathname
    def extension_path_for(path)
      path = extension_pathname.join path.sub(%r{#{source_pathname}/?}, '')
      path = substitute_path_placeholders path

      path
    end

    # Displays the extension naming details to the user on running the command
    def display_extension_naming
      %(#{Color::GREEN}Name:#{Color::CLEAR} #{extension_name}
#{Color::GREEN}Name (Plural):#{Color::CLEAR} #{extension_plural_name}
#{Color::GREEN}Class Name:#{Color::CLEAR} #{extension_class_name}
#{Color::GREEN}Class Name (Plural):#{Color::CLEAR} #{extension_plural_class_name}
#{Color::GREEN}Path:#{Color::CLEAR} #{extension_pathname}
)
    end

    # Kills the generator with a nice message
    # @param [String] msg the message to display
    def kill_with_msg(msg)
      abort msg
    end

    # Checks to see if extension exists, and if so, kill the generator
    def check_extension_path
      msg = "#{Color::RED}Error: An extension already exists in that path#{Color::CLEAR}"
      kill_with_msg(msg) if extension_pathname.directory?
    end
  end
end
