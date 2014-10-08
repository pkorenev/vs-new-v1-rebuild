function loadTwitter() {
    if($(".twitter-share-button").length > 0){
        if (typeof (twttr) != 'undefined') {
            twttr.widgets.load();
        } else {
            $.getScript('http://platform.twitter.com/widgets.js');
        }
    }
}

function loadFacebookLike(){
    var $fb_like = $(".fb-like")
    console.log('fb-like length: '+$fb_like.length)
    if ($fb_like.length > 0) {

        if (typeof (FB) != 'undefined') {
            console.log('facebook if')
            FB.init({ status: true, cookie: true, xfbml: true });
            $('.social-buttons-gem').css({top: '-2px'})
        } else {
            $.getScript("http://connect.facebook.net/en_US/all.js#xfbml=1", function () {
                console.log('facebook else')
                FB.init({ status: true, cookie: true, xfbml: true });
            });
        }
    }
}

function loadGooglePlusButton(){
    var gbuttons = $(".g-plusone");
    if (gbuttons.length > 0) {
        if (typeof (gapi) != 'undefined') {
            gbuttons.each(function () {
                //gapi.plusone.render($(this).get(0));
                gapi.plusone.go()
            });
        } else {
            $.getScript('https://apis.google.com/js/plusone.js');
        }
    }
}

function initFacebook(){
    var bindFacebookEvents, fb_events_bound, fb_root, initializeFacebookSDK, loadFacebookSDK, restoreFacebookRoot, saveFacebookRoot;

    fb_root = null;

    fb_events_bound = false;

    $(function() {
        loadFacebookSDK();
        if (!fb_events_bound) {
            return bindFacebookEvents();
        }
    });

    bindFacebookEvents = function() {
        $(document).on('page:fetch', saveFacebookRoot).on('page:change', restoreFacebookRoot).on('page:load', function() {
            return typeof FB !== "undefined" && FB !== null ? FB.XFBML.parse() : void 0;
        });
        return fb_events_bound = true;
    };

    saveFacebookRoot = function() {
        return fb_root = $('#fb-root').detach();
    };

    restoreFacebookRoot = function() {
        if ($('#fb-root').length > 0) {
            return $('#fb-root').replaceWith(fb_root);
        } else {
            return $('body').append(fb_root);
        }
    };

    loadFacebookSDK = function() {
        window.fbAsyncInit = initializeFacebookSDK;
        return $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1");
    };

    initializeFacebookSDK = function() {
        return FB.init({
            appId: 'YOUR_APP_ID',
            channelUrl: '//WWW.YOUR_DOMAIN.COM/channel.html',
            status: true,
            cookie: true,
            xfbml: true
        });
    };

}

initFacebook();



$(document).on('ready page:load', function () {
    loadTwitter();
    //loadFacebookLike();
    loadGooglePlusButton();
});