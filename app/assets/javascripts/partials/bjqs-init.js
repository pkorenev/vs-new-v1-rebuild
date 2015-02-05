$(document).on('ready page:load', function(){
	$('.banner-outer').each(function(){
        $('.banner-wrapper').bjqs({
            //animtype:'slide'
            //animtype: 'slide'
            animtype: 'fade',
            animspeed: 15000
        });  
    });
});