/*
    Loading animated banners functions
 */
    var development = true;

    if( !development ){
        console = window.console
        console.log = function(){}
        console.error = function(){}
        console.warn = function (){}
    }

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



    $body = $('body')

    var $body_children = $body.children()
    var $body_content = $('<div id="body-content"></div>')
    //$body_content.insertBefore($body_children.first())
    //$body_children.appendTo($body_content)

    $body_content.css({
        zIndex: 5
    })

    var $wrapper = $('#wrapper')

    /*$body_nicescroll = $body.niceScroll({
        scrollspeed: 0,
        mousescrollstep: 10,
        cursorwidth: 15,
        cursorborder: 0,
        cursorcolor: '#2D3032',
        cursorborderradius: 6,
        autohidemode: false,
        horizrailenabled: false
    });*/





    $body.css({
        //paddingRight: '10px'
    })








    // fixed header

    var $header_wrapper = $('#header-wrapper')
    var $body = $('body')

    //$header_wrapper.insertBefore($body.children().first())
    $header_wrapper.wrap('<div id="header-holder"></div>')

    var $header_holder = $('#header-holder')

    $header_holder.wrap('<div id="header-outer"></div>')
    var $header_outer = $('#header-outer')


    var scroll_top = $body.scrollTop()

    var current_header_height = $header_wrapper.height()
    var header_height = 95
    if(scroll_top > 100 && !Modernizr.touch){

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
        width: '100%'
    })

    if(Modernizr.touch){

        var banner_top = header_height - scroll_top;
        if(banner_top < 0)
            banner_top = 0
        $('.fixed-banner-wrapper').css({top: '' + banner_top + 'px'})
    }


    var $header_logo = $('#studio-logo-section')

    console.log('$header_logo')


    $header_outer.css({

    })

    function initHeaderSize(){
        console.log('initHeaderSize()')
        var current_header_height = $header_wrapper.height()
        var header_height = 95
        var scroll_top = $body.scrollTop()

        if(scroll_top > 100 && !Modernizr.touch){
            if(!$body.hasClass('header-compact-height')){
                $body.addClass('header-compact-height')
            }
        }
    }

    initHeaderSize()

    function homeBannerOnScroll(info){
        console.log("homeBannerOnScroll: ", info)
        var scroll_top = info.end.y

        var home_banner_content_top = scroll_top / 3 * (-1)
        var home_banner_opacity = 150 / scroll_top
        if(!isFinite(home_banner_opacity)){
            home_banner_opacity = 1
        }


        var $slide_content = $('#home-banner-outer li.slide div.slide-content')
        $slide_content.css({
            marginTop: home_banner_content_top + 'px'
        })

        $slide_content.find('.layer.description').css({
            opacity: home_banner_opacity
        })

        if(Modernizr.touch){

            var banner_top = header_height - scroll_top;
            if(banner_top < 0)
                banner_top = 0
            $('.fixed-banner-wrapper').css({top: '' + banner_top + 'px'})
        }
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

    //$('#home-banner-outer').insertAfter('#header-outer')
    //$('#portfolio-banner-outer').insertAfter('#header-outer')


    if( typeof $body_nicescroll != 'undefined' && $body_nicescroll ) {

        $('html').addClass('has-nicescroll')

        $body_nicescroll.scrollstart(function (info) {
            console.log('checkHeaderSize(): niceScroll().scrollstart: end.y=' + info.end.y)
            console.log(info)
            //var current_header_height = $header_wrapper.height()
            //var header_height = 95
            //var scroll_top = $body.scrollTop()
            var scroll_top = info.end.y


            if (scroll_top > 100 && !Modernizr.touch) {

                if (!$body.hasClass('header-compact-height')) {
                    $body.addClass('header-compact-height')
                }
            }
            else {
                if ($body.hasClass('header-compact-height')) {
                    $body.removeClass('header-compact-height')
                }
            }


            homeBannerOnScroll(info)
            portfolioBannerOnScroll(info)
        })

        $body_nicescroll.scrollend(function (info) {
            console.log('checkHeaderSize(): niceScroll().scrollend: end.y=' + info.end.y)

            var scroll_top = info.end.y


            if (scroll_top > 100 && !Modernizr.touch) {

                if (!$body.hasClass('header-compact-height')) {
                    $body.addClass('header-compact-height')
                }
            }
            else {
                if ($body.hasClass('header-compact-height')) {
                    $body.removeClass('header-compact-height')
                }
            }

            //alert('hello')
            homeBannerOnScroll(info)
            portfolioBannerOnScroll(info)
        })

    }

    else{
        $(window).scroll(function(){
            var scroll_top = $('body').scrollTop()
            console.log('checkHeaderSize(): niceScroll().scrollstart: end.y=' + scroll_top)
            //console.log(info)




            if (scroll_top > 100 && !Modernizr.touch) {

                if (!$body.hasClass('header-compact-height')) {
                    $body.addClass('header-compact-height')
                }
            }
            else {
                if ($body.hasClass('header-compact-height')) {
                    $body.removeClass('header-compact-height')
                }
            }

            var info = { end: { y: scroll_top } }

            //alert("hello")
            homeBannerOnScroll(info)
            portfolioBannerOnScroll(info)

            setTimeout(function(){
                homeBannerOnScroll(info)
            }, 3000)
        })
    }


    // fix sticky footer when js enabled
    //$('#header-outer').insertBefore( $('#body-content').children().first() )

    //$('#footer-wrapper').appendTo('body')

    $('#body-content').css({
        minHeight: '100%'
    })


    $('#home-banner-outer').insertAfter('#header-outer')

    console.log('header initialized!')



});
