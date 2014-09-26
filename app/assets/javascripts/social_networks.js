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

$(document).on('ready page:load', function () {
    loadTwitter();
    loadFacebookLike();
    loadGooglePlusButton();
});