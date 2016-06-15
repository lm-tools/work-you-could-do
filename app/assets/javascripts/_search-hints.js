(function (window, $) {
  var wycd = window.wycd = window.wycd || {};
  var searchHints = wycd.searchHints = {
    // don't forget to update the static html hint in views/searches/_form.html.erb!
    examples: [
      "Retail",
      "Cook",
      "Administration",
      "Driving",
      "Sales",
      "Nurse",
      "School",
      "Communication",
      "Airport"
    ],
    intervalIDs: []
  };

  function incrementOrReset(index, length) {
    return (index + 1) % length;
  }

  function rotateHintText(element) {
    var index = 0;
    var $element = $(element);
    var updateHintText = function () {
      index = incrementOrReset(index, searchHints.examples.length);
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
