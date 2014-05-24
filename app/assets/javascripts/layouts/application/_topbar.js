jQuery(document).on('ready page:load', function() {
    /* fixed header */

    var scroll_top = $body.scrollTop()



    var current_header_height = $header_wrapper.height()
    var header_height = 95
    if (scroll_top > 100) {

        header_height = 60

    }

    $header_wrapper.css({
        //position: 'fixed',
        height: 'inherit',
        //paddingRight: '10px',
        width: '100%'
    })

    $header_wrapper.wrap('<div id="header-holder"></div>')
    $header_holder = $header_wrapper.parent()

    $header_holder.wrap('<div id="header-outer"></div>')
    var $header_outer = $header_holder.parent()

    $header_holder.css({
        height: 'inherit',
        position: 'fixed',
        width: '100%'
    })

    var $header_logo = $('#studio-logo-section')

    console.log('$header_logo')


    $header_outer.css({

    })

    function initHeaderSize() {
        console.log('initHeaderSize()')
        var current_header_height = $header_wrapper.height()
        var header_height = 95
        var scroll_top = $body.scrollTop()

        if (scroll_top > 100) {
            if (!$body.hasClass('header-compact-height')) {
                $body.addClass('header-compact-height')
            }
        }
    }

    initHeaderSize()

    /* fixed header end */

});