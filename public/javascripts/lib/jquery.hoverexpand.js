(function($) {
  $.fn.hoverexpand = function(options) {
    var defaults = {
      minHeight: '100px'
    };
    var options = $.extend(defaults, options);

    return this.each(function() {
      var $obj = $(this);
      var origHeight = $obj.css('height');
      
      if( parseInt(origHeight) > parseInt(options.minHeight)) {
        $obj.css({
          height: options.minHeight,
          overflow: 'hidden'
        });
      
        $obj.hover(
          function() {
            $obj.animate({height: origHeight }, 500);       //expand
          },
          function() {
            $obj.animate({height: options.minHeight}, 500); //contract
          }
        );
      }
    });
  };
})(jQuery);