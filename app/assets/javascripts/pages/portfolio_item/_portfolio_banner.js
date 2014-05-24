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