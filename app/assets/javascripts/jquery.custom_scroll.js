(function($){
    $.fn.customScroll = function( options ) {

        // Bob's default settings:
        var defaults = {
            speed: 60,
            customGetTotalHeightPx: false,
            customGetCurrentScrollTop: false

            //customGetWindowHeightToDocumentRatio: false
        };

        var settings = $.extend( {}, defaults, options );

        var $this = false;

        var getTotalHeight = function(){
            var total_height = $main_scroller_content.find('#wrapper').height();
            if(settings.customGetTotalHeightPx){
                total_height = settings.customGetTotalHeightPx();

                total_height_func = settings.customGetTotalHeightPx
            }

            return total_height;
        };

        var getCurrentScrollTop = function(){
            $main_scroller_content = $('#main-scroller-content');

            scroll_top = $main_scroller.scrollTop();

            /*if( settings.customGetCurrentScrollTop ){
                scroll_top = settings.customGetCurrentScrollTop.call();
            }*/




            return scroll_top
        };

        var initScrollPosition = function(){

            $main_scroller_content = $('#main-scroller-content');

            scroll_top = $main_scroller.scrollTop();

            var total_height = getTotalHeight();



            var window_height = window.innerHeight;
            window_to_content_height_ratio = window_height / total_height;
            scroll_height_percent = window_to_content_height_ratio * 100;


            window_height = window_height
            current_scroll_top = scroll_top

            if( settings.customGetCurrentScrollTop ){
                current_scroll_top = settings.customGetCurrentScrollTop.call();
            }

            if(settings.customGetTotalHeightPx){
                total_height = settings.customGetTotalHeightPx.call();
            }



            //scroll_height_ratio = $('#main-scroller-content')
            scroll_top_ratio = scroll_top / total_height
            scroll_top_percent = scroll_top_ratio * 100

            $scroll.css({
                height: scroll_height_percent + '%',
                top: scroll_top_percent + '%'
            })
        }



        var createScrollbar = function(){
            $body = $('body')
            $custom_scroll_rails = $('<div class="custom-scroll-rails"></div>')
            $scroll = $('<div></div>')
            $scroll.appendTo($custom_scroll_rails);
            $body.append($custom_scroll_rails);
        };

        var init = function(){
            createScrollbar();

            initScrollPosition();
            $main_scroller = $('#main-scroller');
            $main_scroller.mousewheel(function(event){
                //console.log('mousewheel: event.deltaX:' + event.deltaX + '; event.deltaY' + event.deltaY + '; event.deltaFactor' + event.deltaFactor);
                var current_scroll_top = $main_scroller.scrollTop();
                var new_scroll_top = current_scroll_top + ( event.deltaFactor * (event.deltaY * (-1) ) )
                var total_height = getTotalHeight();
                var window_height = window.innerHeight


                max_scroll_top = total_height - window_height
                min_scroll_top = 0

                if( new_scroll_top >= min_scroll_top && new_scroll_top <= max_scroll_top && new_scroll_top != current_scroll_top){
                    console.warn('new_scroll_top:'+new_scroll_top+'; min: '+min_scroll_top+'; total_height: '+total_height)
                    $main_scroller.scrollTop(new_scroll_top);

                    scroll_top_percent = (new_scroll_top / total_height) * 100

                    $('.custom-scroll-rails > div').css({
                        top: scroll_top_percent + '%'
                    })
                }


            })

        };



        return this.each(function() {
            // Plugin code would go here...


            $this = $(this)
            init();
        });
    }
})(jQuery);