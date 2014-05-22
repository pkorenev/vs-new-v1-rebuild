$(document).on('ready page:load', function() {



    $(".modal-link").each(function() {
        $link = $(this)
        var original_href = $link.attr('href')

        $link.fancybox({
            href: original_href + '?iframe=true',
            padding: 0,
            width: 1100,
            //height: 746,
            autoHeight: true,
            closeBtn: false,
            overlayOpacity: '0.4',
            overlayColor: '#fff',
            closeClick: true,
            scrolling: 'no',
            helpers: {
                overlay: {
                    locked: false
                }
            },
            iframe: {
                preload: true
            },
            beforeLoad: function () {

            },
            afterLoad: function () {

            },
            afterClose: function () {
                $("#contact-form").removeClass("current");
                if (window.location.pathname == "/about") {
                    $("#li-about").addClass("current");
                } else if (window.location.pathname == "/service") {
                    $("#li-service").addClass("current");
                } else if (window.location.pathname == "/articles") {
                    $("#li-article").addClass("current");
                }

            },

            aftershow: function(){
                $iframe = $('.fancybox-iframe')
                $iframe_body = $iframe.contents().find('body')
                $iframe_body_wrapper = $iframe_body.find('#wrapper')


                wrapper_height = $iframe_body_wrapper.height()

                $('.fancybox-wrap, .fancybox-skin, .fancybox-outer, .fancybox-inner, .fancybox-iframe').css({
                    height: '' + wrapper_height + 'px'
                });

                console.log('wrapper_height:'+wrapper_height)
            },

            beforeShow: function () {
                $iframe = $('.fancybox-iframe')
                $iframe_body = $iframe.contents().find('body')
                $iframe_body_wrapper = $iframe_body.find('#wrapper')


                wrapper_height = $iframe_body_wrapper.height()

                $('.fancybox-wrap, .fancybox-skin, .fancybox-outer, .fancybox-inner, .fancybox-iframe').css({
                    height: '' + wrapper_height + 'px'
                });



                $iframe_contact_header = $iframe_body.find('.contact-header')
                $tabs = $iframe_contact_header.find('[id*=tab]')
                $tabs.click(function () {
                    $tab = $(this);
                    $active_tab = $tabs.filter('.contact-active-tab')
                    wrapper_height = $iframe_body_wrapper.height()

                    console.log('wrap_height:' + wrapper_height)

                    $('.fancybox-wrap, .fancybox-skin, .fancybox-outer, .fancybox-inner, .fancybox-iframe').css({
                        height: '' + wrapper_height + 'px'
                    });

                });

                console.log('hello')
            }
        });
    })

    var $window = $(window);

    $window.resize(function() {
        var window_width = window.innerWidth
        var window_height = window.innerHeight
        var $wrapper = $('.fancybox-wrap').find('iframe').contents().find('#wrapper');
        var $inner = $('.fancybox-inner');
        //$inner.height( $wrapper.height() );
        $('.fancybox-wrap, .fancybox-skin, .fancybox-outer, .fancybox-inner, .fancybox-iframe').css({
            'max-height': '' + window_height + 'px',
            'max-width': '' + window_width + 'px'
        });
    })
});


