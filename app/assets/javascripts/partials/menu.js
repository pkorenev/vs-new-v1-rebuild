$(document).on('ready page:load', function(){
$('#header-wrapper').each(function(){
  console.log('init-menu');
$("#contact-form").click(function(){
              // % if current_page?(!root_path)%
                $("nav ul li").removeClass("current");
              // % end %
              $(this).addClass("current");
              //$("#header-wrapper").css(
                  //'z-index', '9999'
              //);
              $("#header-wrapper").css(
                  'background', '#212121'
              );
            });

  $('#mobile-menu-button').click(function(){
    console.log('mobile-menu-button click');
    var $menu_wrapper = $('.menu-wrapper');
    if($menu_wrapper.hasClass('open')){
      //$menu_wrapper.slideUp().removeClass('open');  
      $menu_wrapper.removeClass('open');
      if( !Modernizr.csstransitions ){
        $menu_wrapper.slideUp();

        console.log('slideUp');
      }
    }
    else{
      console.log('!hasClass(open)');
      //$('.menu-wrapper').slideDown().addClass('open');
      $menu_wrapper.addClass('open');
      if( !Modernizr.csstransitions ){
        $menu_wrapper.slideDown();
        console.log('slideDown');
      }
    }
  });
});
});