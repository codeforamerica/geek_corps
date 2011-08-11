(function($) {
  $.fn.hoverexpand = function(options) {
    var defaults = {
      minHeight: '100px',           // If an element has a height greater than minHeight, it will become 'expandable'
      collapsedClass: 'expand-me',  // Class to be added to 'expandable' elements. The class is removed at the end of the expand event
      hoverTime: 500                // Time (in ms) that a user must hover over an element before it expands
    };
    var options = $.extend(defaults, options);

    return this.each(function() {
      var $obj = $(this);
      var origHeight = $obj.css('height');
      var timer = null;
      
      if( parseInt(origHeight) > parseInt(options.minHeight)) {
        $obj.css({
          height: options.minHeight,
          overflow: 'hidden'
        }).addClass(options.collapsedClass);
        
        $obj.hover(
          function() {  // mouseover
            if(!timer) {
              timer = window.setTimeout(function() { 
                $obj.animate({height: origHeight }, 500).removeClass(options.collapsedClass);       //expand
                timer = null;
              }, options.hoverTime);
            }
          },
          function() {  // mouseout
            if(timer) {
              window.clearTimeout(timer);
              timer = null;
            } else {
              $obj.animate({height: options.minHeight}, 500).addClass(options.collapsedClass);    //contract
            }
          }
        );
      }
    });
  };
})(jQuery);