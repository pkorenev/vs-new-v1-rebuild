$(document).on('ready page:load', function() {
    $("#modal-btn").fancybox({
        padding: 0,
        width: 1100,
        height: 680,
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

        }
    });

    var $window = $(window);

    $window.resize(function() {
        var $wrapper = $('.fancybox-wrap').find('iframe').contents().find('#wrapper');
        var $inner = $('.fancybox-inner');
        $inner.height( $wrapper.height() );
    })
});


