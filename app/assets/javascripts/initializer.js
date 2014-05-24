/*
    Loading animated banners functions
 */


    if( !development ){
        console = window.console
        console.log = function(){}
        console.error = function(){}
        console.warn = function(){}
        console.info = function(){}
    }


$(document).on('ready page:load', function() {

    // Check jQuery version
    var version = $().jquery;
    console.info('jQuery version: '+version+'!');






    //$body_content.insertBefore($body_children.first())
    //$body_children.appendTo($body_content)




    // fixed header




    //$header_wrapper.insertBefore($body.children().first())
    $header_wrapper.wrap('<div id="header-holder"></div>')

    var $header_holder = $('#header-holder')

    $header_holder.wrap('<div id="header-outer"></div>')
    var $header_outer = $('#header-outer')








    //$('#home-banner-outer').insertAfter('#header-outer')
    //$('#portfolio-banner-outer').insertAfter('#header-outer')





    // fix sticky footer when js enabled
    //$('#header-outer').insertBefore( $('#body-content').children().first() )

    //$('#footer-wrapper').appendTo('body')





});
