(function (window, $) {
  var wycd = window.wycd = window.wycd || {};
  var searchHints = wycd.searchHints = {
    // don't forget to update the static html hint in views/searches/_form.html.erb!
    examples: [
      "Retail",
      "Administration",
      "Electrical",
    ],
    intervalIDs: []
  };

  function rotateHintText(element) {
    var index = 0;
    var $element = $(element);
    var updateHintText = function () {
      index = (index+1) % searchHints.examples.length;
      $element.fadeOut(300, function() {
        $element
          .text(searchHints.examples[index])
          .fadeIn(300);
      });
    }
    searchHints.intervalIDs.push(setInterval(updateHintText, 5000));
  }

  $("label[for=query] .form-hint .example").each(function() { rotateHintText(this); });
}(this, jQuery));
