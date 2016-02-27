Guts.configure do |config|
  config.file_image_sizing = {
    thumb: "50x50",
    small: "100x100",
    compact: "160x160",
    medium: "240x240",
    large: "480x480",
    grande: "600x600",
    supreme: "1200x1200"
  }
      
  config.file_allowed_content_types = [
    "image/jpg",
    "image/jpeg",
    "image/png",
    "image/gif"
  ]
  
  config.admin_groups = ["Admins"]
end