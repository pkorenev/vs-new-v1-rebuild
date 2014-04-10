$('#portfolio-banner-wrapper').each(function(){
  window.setTimeout(AnimateVoroninWebP, 3000);
});

$('div#portfolio-toolbar').each(function(){
	var $tabs_wrapper = $('#portfolio-toolbar .tabs-wrapper');
      $tabs_wrapper.find('.portfolio-tab').click(function(){
        
        var $tab = $(this);
        var is_tab_active = !( $tab.hasClass('inactive-portfolio-tab') );
        if(!is_tab_active){
          var $active_tab = $tabs_wrapper.find('.portfolio-tab').not('.inactive-portfolio-tab');
          $active_tab.addClass('inactive-portfolio-tab');
          $tab.removeClass('inactive-portfolio-tab');
          var active_tab_id = $active_tab.attr('id');
          var tab_id = $tab.attr('id');

          var $tab_pages_wrapper = $('.portfolio-content .tabpages');
          var $active_tabpage = $tab_pages_wrapper.find('#'+active_tab_id);
          var $tabpage = $tab_pages_wrapper.find('#'+tab_id);
          $public_tabpage = $tabpage;
          $public_active_tabpage = $active_tabpage;
          $active_tabpage.removeClass('active');
          $tabpage.addClass('active');
          console.error('TEST');
        }
        
      });
});

$('.web-slider-wrapper').each(function(){
  (function fn() {
            fn.now = +new Date;
            $(window).load(function() {
              if (+new Date - fn.now < 500) setTimeout(fn, 500);
              var $slider = $('.voronin-studio-banners .scroller');
              
              $('.web-slider-wrapper').each(function(){
                var $wrapper = $(this);
                $('.voronin-studio-banners .scroller').cycle();

                var $left = $('<span class="nav-arrow left-arrow"></span>');
                var $right = $('<span class="nav-arrow right-arrow"></span>');
                $right.click(function(){
                  $slider.cycle('prev');
                });
              
                $left.click(function(){
                  $slider.cycle('next');
                });

                $left.appendTo($wrapper);
                $right.appendTo($wrapper);
              });
              
          
              
            });


          })();
        });

$('div#other-projects').each(function(){
	$('#other-projects a').BlackAndWhite({
        hoverEffect : true, // default true
        // set the path to BnWWorker.js for a superfast implementation
        webworkerPath : false,
        // for the images with a fluid width and height 
        responsive:false,
        // to invert the hover effect
        invertHoverEffect: false,
        // this option works only on the modern browsers ( on IE lower than 9 it remains always 1)
        intensity:1,
        speed: { //this property could also be just speed: value for both fadeIn and fadeOut
            fadeIn: 200, // 200ms for fadeIn animations
            fadeOut: 800 // 800ms for fadeOut animations
        },
        onImageReady:function(img) {
          // this callback gets executed anytime an image is converted
        }
    });

      carousel('.carousel-wrapper');


});

$('.developers-panel-wrapper').each(function(){
  var $links = $(this).find('.dev-field.thanks_image a');
  console.log('links_count:'+$links.length);
	$(this).find('.dev-field.thanks_image a').fancybox();
});