jQuery(document).ready(function($) {
  if ($('body').attr('id').indexOf('guts_navigation') == -1) { return; }

  $(window).on('load', function() {
    if ($('body').attr('id').indexOf('guts_navigation_items_edit') == -1) { return; }

    // Trigger change for edit to run
    $('#navigation_item_navigatable_type').trigger('change');
  });

  $('#navigation_item_navigatable_type').on('change', function() {
    var value = $(this).val();
    if (value === '') {
      // Show custom entry
      $('#navigation_item_navigatable_id').html('').hide();
      $('#navigation_item_custom').show();
    } else {
      // Show dynamic navigatable entries
      $('#navigation_item_navigatable_id').html('').show();
      $('#navigation_item_custom').hide();

      $.ajax({
        url: $(this).data('callback-url'),
        data: {model: $(this).val()},
        dataType: 'json',
      }).done(function(data) {
        $.each(data, function() {
          // Populate the navigatable objects
          $('#navigation_item_navigatable_id').append('<option value="'+this.id+'">'+this.format+'</option>');
        });

        var initial = $('#navigation_item_navigatable_id').data('initial');
        if (initial) {
          // Edit screen, re-select the initial after the AJAX call
          $('#navigation_item_navigatable_id option').each(function() {
            if ($(this).val() == initial) {
              $('#navigation_item_navigatable_id').val($(this).val()).trigger('change');
            }
          });
        }
      });
    }
  });

  $('.sortable').each(function() {
    var url    = $(this).data('url');
    var target = this;

    Sortable.create(target, {
      handle: '.handle',
      onEnd: function() {
        var ids = { };
        $(target).find('.item').each(function() { ids[$(this).index()] = $(this).data('id'); });

        $.post(url, { order: ids });
      }
    });
  });
});
