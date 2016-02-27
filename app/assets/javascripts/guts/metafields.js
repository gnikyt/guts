jQuery(document).ready(function($) {
  if ($("body").attr("id").indexOf("guts_metafields") == -1) { return; }
  
  $(".metafield_add").on("click", function(e) {
    e.preventDefault();
    
    swal({
      title: "New Metafield",
      text: "What is the key for this field?",
      type: "input",
      showCancelButton: true,
      closeOnConfirm: false,
      animation: "slide-from-top"
    }, function(value){
      if (value === false) return false;
      
      if (value === "") {
        swal.showInputError("You need to write something!");
      } else {
        var template   = Handlebars.compile($("#metafields_template").html());
        var $container = $(".metafields_container");
        
        if ($container.find("p").length) { $container.html(""); }
        $container.append(template({key: value}));

        swal.close();
      }
    });
  });
  
  $(document).on("click", ".metafield_destroy", function(e) {
    e.preventDefault();
    
    var $that = $(this);
    
    swal({
      title: "Are you sure?",
      text: "You will not be able to recover this metafield after deletion.",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, delete it!",
      closeOnConfirm: false
    }, function() {
      swal.close();
      
      $that.parents(".metafield").fadeOut("slow", function() { $(this).remove(); });
    });
  });
  
  $(document).on("click", ".metafield_expand", function(e) {
    e.preventDefault();
    
    var $parent = $(this).parents(".metafield");
    var index   = $parent.index();
    var label   = $parent.find("label").text();
    var value   = $parent.find("textarea").val();
    
    var template = Handlebars.compile($("#metafield_expand_template").html());
    
    $("#metafield_expand_modal").find(".template").html(template({key: label, value: value, index: index}));
    $("#metafield_expand_modal").foundation("open");
  });
  
  $(document).on("click", "#metafield_expand_save", function(e) {
    e.preventDefault();
    
    var $parent = $(this).parents("form");
    var index   = $parent.data("metafield-index");
    var value   = $parent.find("textarea").val();
    
    $($(".metafield").get(index)).find("textarea").val(value);
    $("#metafield_expand_modal").find("template").html("");
    $("#metafield_expand_modal").foundation("close");
  });
});