# Configurations

## Setting

Theres a couple ways to set configuration values.

### Option 1: Blocks

``` ruby
Guts.configure do |config|
  config.my_key = "some value"
end
```

You could also place this in your Rails application under `config/initializers/guts.rb`

### Option 2

``` ruby
Guts.configuration.my_key = "my_value"
```

## Getting

To grab a configuration value simply do `Guts.configuration.{you_key}`.

## Default Configurations

These configurations can be overwritten.

`config.file_image_sizing` returns a list of sizes for Paperclip to use.

``` ruby
{
  thumb: "50x50",
  small: "100x100",
  compact: "160x160",
  medium: "240x240",
  large: "480x480",
  grande: "600x600",
  supreme: "1200x1200"
}
```

`config.file_allowed_content_types` returns a list of mime-types accepted by Paperclip.

``` ruby
[
  "image/jpg",
  "image/jpeg",
  "image/png",
  "image/gif"
]
```

`config.admin_groups` returns a list of user groups allowed to access the admin panel.

``` ruby
["Admins"]
```

