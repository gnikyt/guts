# Guts & TinyMCE

Guts uses the [tinymce-rails](https://github.com/spohlenz/tinymce-rails) gem. See their documentation for full details, below is an example setup guide on how to configure TinyMCE to include our plugins.

## Configuration

### Option 1: Pre-Created

For a pre-created file copy our `tinymce.yml` from `test/dummy/config` in Guts' repository to your applications `config` directory and you're good to good.

### Option 2: Rolling Your Own

If you're already using a `tinymce.yml` config or you'd like to create your own. Simply be sure to add `guts_media` to the plugins list in the YAML file.

```yaml
plugins:
    - guts_media
    - advlinks
    - ...
```



