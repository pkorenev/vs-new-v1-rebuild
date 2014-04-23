$(document).on('ready page:load', function() {
    $(".modal-link").fancybox({
        padding: 0,
        width: 1100,
        height: 746,
        autoHeight:true,
        closeBtn: false,
        overlayOpacity: '0.4',
        overlayColor: '#fff',
        closeClick: true,
        scrolling:'no',
        helpers: {
             overlay: {
                locked: false
            }
        },
        iframe: {
            preload   : true
        },
        afterClose: function(){
            $("#contact-form").removeClass("current");
            if (window.location.pathname == "/about"){
              $("#li-about").addClass("current");
            }else if(window.location.pathname == "/service"){
              $("#li-service").addClass("current");
            }else if(window.location.pathname == "/articles"){
                $("#li-article").addClass("current");
            }

        },

        beforeShow: function(){
            $iframe = $('.fancybox-iframe')
            $iframe_body = $iframe.contents().find('body')
            $iframe_body_wrapper = $iframe_body.find('#wrapper')

            $iframe_contact_header = $iframe_body.find('.contact-header')
            $tabs = $iframe_contact_header.find('[id*=tab]')
            $tabs.click(function(){
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


    $('.modal-link').click(function(e){
        e.preventDefault();
    });

    var $window = $(window);

    $window.resize(function() {
        var $wrapper = $('.fancybox-wrap').find('iframe').contents().find('#wrapper');
        var $inner = $('.fancybox-inner');
        $inner.height( $wrapper.height() );
    })
});


