


jQuery(document).on('ready page:load', function(){




    //= require custom/layout/application



    //= require custom/pages/home

    $('#body-content').css({
        minHeight: '100%'
    })


    $('#home-banner-outer').insertAfter('#header-outer')

    console.log('header initialized!')


});