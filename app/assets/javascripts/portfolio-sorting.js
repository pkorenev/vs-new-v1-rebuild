function getItemsPerRow (){
      var items_per_row = 6;

          if(window.innerWidth <= 1200 && window.innerWidth > 960){
            items_per_row = 4;
          }
          
          else if(window.innerWidth <= 960 && window.innerWidth > 600){
            items_per_row = 3;
          }

          else if(window.innerWidth <= 600){
            items_per_row = 2;
          }

          return items_per_row;
    }

function PortfolioFilter(filter){
    var $container = $('.sortable-portfolio');
    $container.isotope({
        filter: filter,
        resizable:true,
        resizesContainer: true,
        layoutMode: 'fitRowsWithHeight',
        //masonry: { columnWidth: $container.width() / 6 - 10 },
        animationOptions: {
            duration: 750,
            easing: 'linear',
            queue: false
        },
        animationEngine : "jquery"
    });

    normalize(filter);
}

function PortfolioShowAll(){

    // Caching selector
    
    PortfolioFilter('.portfolio-item');

    //normalize('nnn');
}

function normalize(filterClass){
    var items_per_row = getItemsPerRow();
    var $container = $('.sortable-portfolio');
    $container.find('.isotope-item.isotope-hidden').each(function(){
        var $isotope_item = $(this);
        if(!$isotope_item.hasClass(filterClass)){
            var item_original_order = $isotope_item.data('isotopeSortData')['original-order'];

            var item_height = $isotope_item.outerHeight(true);
            var item_width = $isotope_item.outerWidth(true);
            //var items_per_row = $container.width() / item_width;
            //items_per_row = 6;
            //if(items)
            var item_top = Math.floor(item_original_order / items_per_row) * item_height;
            var item_left = ( (item_original_order-1) % items_per_row ) * item_width;
            console.log('rendered for '+items_per_row+' items per row');


            $isotope_item.delay(750).css({top:item_top,left:item_left});

        }
    });
}

function PortfolioShowFirm(){
    // Caching selector
    var filter = '.corporate-identity';
    PortfolioFilter(filter);

    //normalize('firm');
}

function PortfolioShowPoly(){
    // Caching selector
    var $container = $('.sortable-portfolio');

    PortfolioFilter('.polygraphy');

    //normalize('poly');
}

function PortfolioShowWeb(){
    // Caching selector
    PortfolioFilter('.web');

    //normalize('web');
}





function visualizePortfolioShowAll(){
    var $tab = $(this);
    var tab_id = $tab.attr('id');
    if($tab.hasClass("inactive-portfolio-tab")){
        $(".portfolio-tab").addClass("inactive-portfolio-tab");
        if( location.pathname == '/portfolio' || location.pathname == '/portfolio/'){
                location.hash = tab_id;
        }
        $tab.removeClass("inactive-portfolio-tab");
        PortfolioShowAll();
    }
}

      function visualizePortfolioShowFirmStyles(){
        var $tab = $(this);
        var tab_id = $tab.attr('id');
        if($tab.hasClass("inactive-portfolio-tab")){

        $(".portfolio-tab").addClass("inactive-portfolio-tab");
          if( location.pathname == '/portfolio' || location.pathname == '/portfolio/'){
                location.hash = tab_id;
            }
        $tab.removeClass("inactive-portfolio-tab");
        PortfolioShowFirm();
    }
      }

      function visualizePortfolioShowPolygraphy(){
        var $tab = $(this);
        var tab_id = $tab.attr('id');
        if($tab.hasClass("inactive-portfolio-tab")){
            $(".portfolio-tab").addClass("inactive-portfolio-tab");
            if( location.pathname == '/portfolio' || location.pathname == '/portfolio/'){
                location.hash = tab_id;
            }
            $tab.removeClass("inactive-portfolio-tab");
            PortfolioShowPoly();
        }
      }

      function visualizePortfolioShowWeb(){
        var $tab = $(this);
        var tab_id = $tab.attr('id');
        if($tab.hasClass("inactive-portfolio-tab")){
            $(".portfolio-tab").addClass("inactive-portfolio-tab");
            if( location.pathname == '/portfolio' || location.pathname == '/portfolio/'){
                location.hash = tab_id;
            }
            $tab.removeClass("inactive-portfolio-tab");
            PortfolioShowWeb();
        }
      }

      function handleUrlAnchors(){
        var isInitialized = false;
        if( (location.pathname == '/portfolio' || location.pathname == '/portfolio/') && location.hash.length>0 ){;
            $('.portfolio-tab.inactive-portfolio-tab').each(function(){
                var $tab = $(this);
                var tab_id = $tab.attr('id');
                if('#'+tab_id == location.hash ){
                    if( tab_id == 'firm-styles' ){
                        visualizePortfolioShowFirmStyles.call($tab);
                        isInitialized =true;
                    }
                    else if( tab_id == 'polygraphy' ){
                        isInitialized = true;
                        visualizePortfolioShowPolygraphy.call($tab);
                    }
                    else if( tab_id == 'web-sites' ){
                        isInitialized = true;
                        visualizePortfolioShowWeb.call($tab);
                    }
                }
            });
        }

        if(!isInitialized){
            PortfolioShowAll();
        }
      }