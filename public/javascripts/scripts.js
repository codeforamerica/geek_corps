$(function(){
  $('#isotope-container').isotope({
  // options
  itemSelector : '.isotope-object',
  layoutMode : 'masonry',
  animationEngine: 'best-available',
  masonry : {
    columnWidth : 2
  }
  });
  $('#filters a').click(function(){
  var selector = $(this).attr('data-filter');
  $('#isotope-container').isotope({ filter: selector });
  return false;
  });
});