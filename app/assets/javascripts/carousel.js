function carousel(selector){
    var $wrapper = $(selector);
    var $carousel = $wrapper.find('ul');
    var $items = $carousel.find('li');


    init = function() {
        handleSize();

        $(window).resize(function(){
            handleSize();
        });
    };

    getItemsPerRow = function(){
        if(window.innerWidth >= 2020){
            return 12;
        }
        if(window.innerWidth >= 1600){
            return 10;
        }
        if(window.innerWidth >= 1200){
            return 8;
        }
        if(window.innerWidth >= 960){
            return 6;
        }
        if(window.innerWidth >= 600){
            return 4;
        }
        if(window.innerWidth >= 300){
            return 2;
        }
        return 1;
    }

    handleSize = function() {
        var items_per_row = getItemsPerRow();
        if($carousel.data('items_per_row') != items_per_row ){
            $carousel.data('items_per_row',items_per_row);
            $carousel.css({
                width:''+(  100 * ($items.length) / items_per_row ) + '%'
            });

            var item_percent_width = 100 / $items.length;

            $items.css({
                width: ''+( item_percent_width  ) + '%'
            });
            // fix for linux chrome
            $items.last().css({
                width: ''+( item_percent_width - 0.01 ) + '%'
            });
        }
    }

    init();
}