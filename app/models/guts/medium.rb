module Guts
  # Medium model which utilizes PaperClip
  class Medium < ApplicationRecord
    include MultisiteScopeConcern

    # Regex used for sizing_only_images
    CONTENT_TYPE_REGEX = %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$}
    
    belongs_to :filable, polymorphic: true, required: false
    has_attached_file(
      :file,
      source_file_options: { all: '-auto-orient' },
      styles: Guts.configuration.file_image_sizing,
      url: '/system/:class/:id_partition/:style/:filename',
      path: ':rails_root/public/system/:class/:id_partition/:style/:filename'
    )

    validates_attachment_content_type(
      :file,
      content_type: Guts.configuration.file_allowed_content_types
    )

    before_post_process :sizing_only_images

    before_save :default_title

    # Determine if the file is an image
    # and can be resized by Paperclip
    # @return [Boolean] true for image, false for file
    def sizing_only_images
      false unless self[:file_content_type] =~ CONTENT_TYPE_REGEX
    end

    # Creates a title based on the file name if
    # no title was entered
    def default_title
      self[:title] = self[:file_file_name] if self[:title].blank?
    end
  end
end
