(function() {
  var expand_content_width, last_width;

  $(function() {
    return $(".expand").on("click", expand_content_width);
  });

  last_width = null;

  expand_content_width = function() {
    var cont, width;

    cont = $(".content");
    width = cont.css("max-width");
    if (width !== "100%") {
      last_width = width;
      return cont.css("max-width", "100%");
    } else {
      return cont.css("max-width", last_width);
    }
  };

}).call(this);
