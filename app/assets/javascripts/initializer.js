/*
    Loading animated banners functions
 */
    var development = true;

    function ShowBannerOnLoad(){
        if(development == true){
            $('#wrap-banner').animate(
                { height: 648 },
                { duration: 4000,
                  easing: 'easeOutElastic'
                },
                { avoidCSSTransitions: true
            });
        }else{

        }
    }


$(document).on('ready page:load', function() {

    // Check jQuery version
    var version = $().jquery;
    console.info('jQuery version: '+version+'!');

    // Logo right click event
    $('#studio-logo-section').bind('contextmenu', function(e){
        return false;
    });

    // Check for notification permissions
    // temporary disabled
    //$(document).click(CheckForNotificationsPermission);

    // Log current user location after 2 seconds
    // temporary disabled
    //window.setTimeout(getCurrentPosition, 2000);

    /*
        Send a notification to a WebKit user!
        Notifications should be send with this type of events:
        new article arrive
        new service has been added
        new changes to a site design
        new portfolio work has been added

        Usage:
        @function SendNotification
        @params: image_n (Notification log)
        @params: title_n (Notification title)
        @params: message_n (Notification message body text)
        @params: url_n (Notification link that will be opened for user when (s)he click on banner)
     */

    //var NewSubversion = SendNotification('/assets/notify.png', 'Testing notification!', 'This is random notification!', 'https://github.com/vikewoods');
    //window.setTimeout(NewSubversion, 50000);


    /* * * * * * * * * * * * * * * * * * * Nice scroll * * * * * * * * * * * * * * * * * * * * * * * * */

    /*function niceScrollInit(){
        $("html").niceScroll({
            scrollspeed: 60,
            mousescrollstep: 40,
            cursorwidth: 15,
            cursorborder: 0,
            cursorcolor: '#2D3032',
            cursorborderradius: 6,
            autohidemode: false,
            horizrailenabled: false
        });

        if($('#boxed').length == 0){
            $('body, body #header-outer, body #header-secondary-outer, body #search-outer').css('padding-right','16px');
        }

        $('html').addClass('no-overflow-y');
    }

    var $smoothActive = $('body').attr('data-smooth-scrolling');
    var $smoothCache = ( $smoothActive == 1 ) ? true : false;

    if( $smoothActive == 1 && $(window).width() > 690 && $('body').outerHeight(true) > $(window).height()){ niceScrollInit(); } else {
        $('body').attr('data-smooth-scrolling','0');
    }*/

    $body = $('body')

    var $body_children = $body.children()
    var $body_content = $('<div id="body-content"></div>')
    $body_content.insertBefore($body_children.first())
    $body_children.appendTo($body_content)

    $body.niceScroll({
        scrollspeed: 60,
        mousescrollstep: 40,
        cursorwidth: 15,
        cursorborder: 0,
        cursorcolor: '#2D3032',
        cursorborderradius: 6,
        autohidemode: false,
        horizrailenabled: false
    });



    $body.css({
        paddingRight: '10px'
    })








    // fixed header

    var $header_wrapper = $('#header-wrapper')
    var $body = $('body')

    $header_wrapper.insertBefore($body.children().first())
    $header_wrapper.wrap('<div id="header-holder"></div>')

    var $header_holder = $('#header-holder')

    $header_holder.wrap('<div id="header-outer"></div>')
    var $header_outer = $('#header-outer')


    var scroll_top = $body.scrollTop()

    var current_header_height = $header_wrapper.height()
    var header_height = 95
    if(scroll_top > 100){

        header_height = 60

    }

    $header_wrapper.css({
        //position: 'fixed',
        height: 'inherit',
        //paddingRight: '10px',
        width: '100%'
    })

    $header_holder.css({
        height: 'inherit',
        position: 'fixed',
        width: '100%',


    })

    $header_outer.css({

    })

    function initHeaderSize(){
        console.log('initHeaderSize()')
        var current_header_height = $header_wrapper.height()
        var header_height = 95
        var scroll_top = $body.scrollTop()

        if(scroll_top > 100){
            if(!$body.hasClass('header-compact-height')){
                $body.addClass('header-compact-height')
            }
        }
    }

    initHeaderSize()

    function homeBannerOnScroll(info){
        var scroll_top = info.end.y

        var home_banner_content_top = scroll_top / 3 * (-1)
        var home_banner_opacity = 150 / scroll_top
        $('#home-banner-outer .slide .slide-content').css({
            marginTop: home_banner_content_top + 'px'
        })

        $('#home-banner-outer .slide .slide-content .layer.description').css({
            opacity: home_banner_opacity
        })
    }

    function portfolioBannerOnScroll(info){
        var scroll_top = info.end.y


        var portfolio_banner_content_top = scroll_top / 3 * (-1)
        var portfolio_banner_opacity = 150 / scroll_top
        $('#portfolio-banner-outer .slide .slide-description').css({
            marginTop: portfolio_banner_content_top + 'px'
        })

        $('#portfolio-banner-outer .slide .slide-description').css({
            opacity: portfolio_banner_opacity
        })
    }

    $('#home-banner-outer').insertAfter('#header-outer')
    $('#portfolio-banner-outer').insertAfter('#header-outer')

    $body.niceScroll().scrollstart(function(info){
        console.log('checkHeaderSize(): niceScroll().scrollstart: end.y='+info.end.y)
        console.log(info)
        //var current_header_height = $header_wrapper.height()
        //var header_height = 95
        //var scroll_top = $body.scrollTop()
        var scroll_top = info.end.y


        if(scroll_top > 100){

            if(!$body.hasClass('header-compact-height')){
                $body.addClass('header-compact-height')
            }
        }
        else{
            if($body.hasClass('header-compact-height')){
                $body.removeClass('header-compact-height')
            }
        }



        homeBannerOnScroll(info)
        portfolioBannerOnScroll(info)
    })

    $body.niceScroll().scrollend(function(info){
        console.log('checkHeaderSize(): niceScroll().scrollend: end.y='+info.end.y)

        var scroll_top = info.end.y


        if(scroll_top > 100){

            if(!$body.hasClass('header-compact-height')){
                $body.addClass('header-compact-height')
            }
        }
        else{
            if($body.hasClass('header-compact-height')){
                $body.removeClass('header-compact-height')
            }
        }


        homeBannerOnScroll(info)
        portfolioBannerOnScroll(info)
    })


    console.log('header initialized!')


    // home slider

    /*$body.niceScroll().scrollstart(function(info){
        scroll_top = info.end.y
    })

    $body.niceScroll().scrollend(function(info){

    })*/

    // home slider

    /*$main_scroller = $('#main-scroller')

    function getDocumentHeight(){

    }

    function initScrollPosition(){

        $main_scroller_content = $('#main-scroller-content')

        scroll_top = $main_scroller.scrollTop()
        content_height = $main_scroller_content.find('#wrapper').height()
        window_height = window.innerHeight
        window_to_content_height_ratio = window_height / content_height
        scroll_height_percent = window_to_content_height_ratio * 100

        //scroll_height_ratio = $('#main-scroller-content')
        scroll_top_ratio = scroll_top / content_height
        scroll_top_percent = scroll_top_ratio * 100

        $scroll.css({
            height: scroll_height_percent + '%',
            top: scroll_top_percent + '%'
        })
    }

    function initScrollbar(){
        $body = $('body')
        $custom_scroll_rails = $('<div class="custom-scroll-rails"></div>')
        $scroll = $('<div></div>')
        $scroll.appendTo($custom_scroll_rails);
        $body.append($custom_scroll_rails);

        initScrollPosition();

        //$main_scroller.scroll(initScrollPosition);

        $main_scroller.mousewheel(function(event){
            //console.log('mousewheel: event.deltaX:' + event.deltaX + '; event.deltaY' + event.deltaY + '; event.deltaFactor' + event.deltaFactor);
            var current_scroll_top = $main_scroller.scrollTop();
            var new_scroll_top = current_scroll_top + ( event.deltaFactor * (event.deltaY * (-1) ) )
            //console.log('new_scroll_top:'+new_scroll_top)
            $main_scroller.scrollTop(new_scroll_top);
        })
    }
*/


    //initScrollbar();








    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


    /*$wrapper = $('#wrapper');

    $main = $('#main');

    $footer = $('#footer-wrapper');

    $footer.appendTo($wrapper);

    $header = $('#header-wrapper');

    $banner_container = $('#banner-container');

    $banner_container.insertAfter($header);

    $banner_container.wrap('<div id="banner-outer"></div>');
    $banner_outer = $('#banner-outer')

    $page_content = $('#page-content');

    $page_content.wrap('<div id="page-content-wrapper"></div>')
    $page_content_wrapper = $('#page-content-wrapper');

    banner_height = $banner_outer.height();
    header_height = $header.height();
    window_height = window.innerHeight;

    page_content_wrapper_height = window_height - banner_height - header_height

    //$page_content_wrapper.height(page_content_wrapper_height)

    $banner_outer.insertBefore($page_content.children().first())


    $header.css({
       position: 'fixed',
       zIndex: '10000000',
       //width: '100%',
       top: 0,
       left: 0,
       right: '15px',
       margin: 0
    });

    $banner_outer.css({
       position: 'relative',
       overflow: 'hidden',
       zIndex: '100000',
       //width: '100%',
       right: '15px',
       //top: '95px',
       left: 0
    });
    page_content_top = $header.height()
    $page_content_wrapper.css({marginTop: page_content_top})

    var $banner_wrapper = $('#banner-wrapper')
    $banner_outer.css({

    })

    $main_scroller.scroll(function(){
        var scroll_top = $main_scroller.scrollTop();
        var banner_outer_height = $banner_outer.height()

        var banner_wrapper_height = $banner_wrapper.height()

        var $slider = $('ul.slider')


        var slider_top = scroll_top
        var slider_height = banner_wrapper_height - scroll_top

        $slider.animate({
            marginTop: slider_top + 'px',
            //height: slider_height + 'px'
        })
    });*/





    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * OLD CODE * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

//    $('#main-scroller').customScroll({
//        customGetTotalHeightPx: function(){
//            scroll_top = $('#main-scroller').scrollTop();
//            natural_banner_height = $('#banner-container').height();
//
//            if(scroll_top > 100){
//                header_height = 75;
//            }
//            else{
//                header_height = 95;
//            }
//
//            total_document_height = header_height + natural_banner_height + $page_content_wrapper.height();
//
//            return total_document_height
//        }/*,
//        customGetCurrentScrollTop: function(){
//
//        }*/
//    });

//    $('#main-scroller').scroll(function(){
//       //console.log('scrollTop:'+$(this).scrollTop()+'; height: '+$('#page-content-wrapper').height())
//
//        scroll_top = $('#main-scroller').scrollTop()
//
//
//        if(scroll_top > 100){
//            header_height = 75;
//        }
//        else{
//            header_height = 95;
//        }
//
//        natural_banner_height = $('#banner-container').height();
//        total_document_height = header_height + natural_banner_height + $page_content_wrapper.height();
//
//        $header.css({
//            height: header_height + 'px'
//        });
//
//
//        banner_outer_height = natural_banner_height * ( (total_document_height - (scroll_top * 3) ) / total_document_height )
//        $banner_outer.css({
//            height: banner_outer_height + 'px',
//            top: header_height + 'px'
//        });
//
//
//        window_height = window.innerHeight
//        page_content_top =  header_height + banner_outer_height
//
//        if(page_content_top < header_height){
//            page_content_top = header_height;
//        }
//        else{
//
//        }
//
//        if(banner_outer_height > 0){
//            page_content_top += scroll_top
//        }
//        else{
//
//            page_content_top += scroll_top
//
//            //page_content_top = header_height + natural_banner_height - scroll_top
//        }
//
//
//        $page_content_wrapper.css({
//            marginTop: page_content_top + 'px'
//        });
//    });
});
