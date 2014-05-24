/* custom scroll */

/*
$html_nicescroll = $html.niceScroll({
 scrollspeed: 60,
 mousescrollstep: 40,
 cursorwidth: 15,
 cursorborder: 0,
 cursorcolor: '#2D3032',
 cursorborderradius: 6,
 autohidemode: false,
 horizrailenabled: false
 });
*/


if( typeof $html_nicescroll != 'undefined' && $html_nicescroll ) {


    var $body_content = $('<div id="body-content"></div>')

    $body_content.css({
        zIndex: 5
    })

    $html.addClass('has-nicescroll')
    if($html.hasClass('has-nicescroll'))
        console.log('hello2')
    else
        console.log('hello3')

    $html_nicescroll.scrollstart(function (info) {
        console.log('checkHeaderSize(): niceScroll().scrollstart: end.y=' + info.end.y)
        console.log(info)
        //var current_header_height = $header_wrapper.height()
        //var header_height = 95
        //var scroll_top = $body.scrollTop()
        var scroll_top = info.end.y


        if (scroll_top > 100) {

            if (!$body.hasClass('header-compact-height')) {
                $body.addClass('header-compact-height')
            }
        }
        else {
            if ($body.hasClass('header-compact-height')) {
                $body.removeClass('header-compact-height')
            }
        }


        if(typeof homeBannerOnScroll == 'function'){
            homeBannerOnScroll(info)
        }
        if(typeof portfolioBannerOnScroll == 'function') {
            portfolioBannerOnScroll(info)
        }
    })

    $html_nicescroll.scrollend(function (info) {
        console.log('checkHeaderSize(): niceScroll().scrollend: end.y=' + info.end.y)

        var scroll_top = info.end.y


        if (scroll_top > 100) {

            if (!$body.hasClass('header-compact-height')) {
                $body.addClass('header-compact-height')
            }
        }
        else {
            if ($body.hasClass('header-compact-height')) {
                $body.removeClass('header-compact-height')
            }
        }

        if(typeof homeBannerOnScroll == 'function'){
            homeBannerOnScroll(info)
        }
        if(typeof portfolioBannerOnScroll == 'function') {
            portfolioBannerOnScroll(info)
        }
    })

}

/* custom scroll end */