jQuery(document).ready(function($) {
  $('.media_add').on('click', function() {
    $(this).remove();
    $('.media_add_new').show();
  });

  $('.media_destroy').on('click', function(e) {
    e.preventDefault();

    var $that = $(this);

    swal({
      title: 'Are you sure?',
      text: 'You will not be able to recover this attachment after deletion.',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Yes, delete it!',
      closeOnConfirm: false
    }, function() {
      swal.close();

      $that.parents('.media_block').find('input[type=checkbox]').trigger('click');
      $that.parents('.media_block').fadeOut('slow');
    });
  });

  if (window.top.tinymce && window.top != window) {
    $('.media_insert').css('display', 'inline');

    $(document).on('click', '#media_insert_size', function() {
      var size = $(this).parent().find('select').val();
      var file = $(this).parent().find('#media_insert_file_link');

      var editor = window.top.tinymce.editors[0];
      editor.insertContent('<img src="'+file.val().replace('original', size)+'" alt="Image">');
      editor.windowManager.close();
    });

    $('.media_insert').on('click', function(e) {
      e.preventDefault();

      if ($(this).data('type').indexOf('image') != -1) {
        var modal = $('#media_insert_modal');
        $.get($(this).attr('href'), function(resp) { modal.html(resp).foundation('open'); });
      } else {
        var editor = window.top.tinymce.editors[0];
        editor.insertContent('<a href="'+$(this).data('url')+'" target="_blank">'+$(this).data('title')+'</a>');
        editor.windowManager.close();
      }
    })
  }

  // Dropzone.js
  Dropzone.autoDiscover = false;
  var myDropzone = new Dropzone('#new_medium', {
    paramName: 'medium[file]',
    autoProcessQueue: false,
  });
});
