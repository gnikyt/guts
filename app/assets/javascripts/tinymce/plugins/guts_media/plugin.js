tinymce.PluginManager.add('guts_media', function(editor, url) {
  editor.addButton('guts_media', {
    text: null,
    icon: 'browse',
    onclick: function () {
      editor.windowManager.open({
        title: 'Browse',
        url: TINYMCE_GUTS_MEDIA_PATH+'?insert=1',
        width: 700,
        height: 700
      });
    }
  });
});
