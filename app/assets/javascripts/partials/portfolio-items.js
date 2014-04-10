$(document).on('ready page:load',function(){
$('#home-portfolio, #portfolio-index').each(function(){
// Bind tabs

  function initPortfolioItems(){
    console.log('initPortfolioItems');
  handleUrlAnchors();

    

    function handleWindowResize(){
        //$container.isotope({
          // update columnWidth to a percentage of container width
          //masonry: { columnWidth: $container.width() / 7 }

        //});
      var $container = $('.sortable-portfolio');  
      var container_isotope_data = $container.data('isotope');
      if(container_isotope_data){
        console.warn('isotope is available');
        var item = container_isotope_data.$filteredAtoms[0];
        var $item = $(item);
        var item_height = $item.outerHeight(true);
        var item_width = $item.outerHeight(true);
        container_height = Math.ceil(container_isotope_data.$filteredAtoms.length / 6) * item_height;
        $container.css('height',''+container_height+'px');

        var $filtered_items = $(container_isotope_data.$filteredAtoms);
        $filtered_items.each(function(index){
          var $item = $(this);
          var item_left = (index%6) * item_width;
          var item_top = Math.floor( (index) / 6 ) * item_height;

          $item.css({left:item_left,top:item_top});
        });
      }
    }
      
    //$(window).smartresize(handleWindowResize);
    //$(window).smartresize(function(){
    //  $('.sortable-portfolio').isotope({masonry:{columnWidth:$('.sortable-portfolio').width()/6 - 10 }})
    //});
    //PortfolioShowAll();
    //handleWindowResize.call($(window));

    
    

  //$(window).load(function(){
    $('.portfolio-item a').BlackAndWhite({
        hoverEffect : true, // default true
        // set the path to BnWWorker.js for a superfast implementation
        webworkerPath : false,
        // for the images with a fluid width and height 
        responsive:true,
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
  }
//});
initPortfolioItems();
//document.addEventListener("page:load", initPortfolioItems);
});
});