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

    $("#main-scroller").niceScroll({
        scrollspeed: 60,
        mousescrollstep: 40,
        cursorwidth: 15,
        cursorborder: 0,
        cursorcolor: '#2D3032',
        cursorborderradius: 6,
        autohidemode: false,
        horizrailenabled: false
    });



    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

});
