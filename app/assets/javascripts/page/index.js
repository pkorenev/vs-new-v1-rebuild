$(document).on('ready page:load',function(){

  $('#home-portfolio').each(function(){
  $(' .portfolio-tab').click(function(){
    var top = $('#portfolio-items-container').offset().top;
    $('body,html').animate({scrollTop: top}, 800);
  });
});
});