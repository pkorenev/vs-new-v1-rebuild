function homeBannerOnScroll(info){
    var scroll_top = info.end.y
    var transform_translate_y;


    if(scroll_top > 100) {
        transform_translate_y = scroll_top / 10;
        content_transform_translate_y = scroll_top / 3
    }
    else{
        transform_translate_y = -95;
        content_transform_translate_y = 95;
    }

    $home_banner_outer = $('#home-banner-outer')

    var content_transform_string = 'translate(0,'+content_transform_translate_y+'px)'
    var transform_string = 'translate(0,'+transform_translate_y+'px)'
    $home_banner_outer.css({
        '-o-transform': transform_string,
        '-webkit-transform': transform_string,
        '-ms-transform': transform_string,
        '-moz-transform': transform_string,
        'transorm': transform_string,

        'margin-top': '-95px'
    })

    var home_banner_content_top = scroll_top / 3 * (-1)
    var home_banner_opacity = 150 / scroll_top
    $('#home-banner-outer .slide .slide-content').css({
        //marginTop: home_banner_content_top + 'px'
        '-o-transform': content_transform_string,
        '-webkit-transform': content_transform_string,
        '-ms-transform': content_transform_string,
        '-moz-transform': content_transform_string,
        'transorm': content_transform_string
    })

    $('#home-banner-outer .slide .slide-content .layer.description').css({
        opacity: home_banner_opacity
    })
}


$('.banner-outer').each(function(){
    $('.banner-wrapper').bjqs({
        //animtype:'slide'
        //animtype: 'slide'
        animtype: 'fade',
        animspeed: 15000
    });
});

// ../../partials/bjqs-init
// home_banner_slides/slide-valko
// home_banner_slides/slide-g3k
// home_banner_slides/slide-czmk