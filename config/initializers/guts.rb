Guts.configure do |config|
  # Default image sizing
  # Images will be sized to these specifications by PaperClip
  # A dropdown for inserting images into TinyMCE will also show these choices
  config.file_image_sizing = {
    thumb: '50x50',
    small: '100x100',
    compact: '160x160',
    medium: '240x240',
    large: '480x480',
    grande: '600x600',
    supreme: '1200x1200'
  }

  # Default allowed file types which PaperClip will accept
  config.file_allowed_content_types = [
    'image/jpg',
    'image/jpeg',
    'image/png',
    'image/gif',
    'application/pdf',
    'text/plain'
  ]
end
