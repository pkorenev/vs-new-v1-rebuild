function set_path(){
    if( !!(window.history && history.pushState) ){

    }
    else{
        location.hash = category_url;
    }
}

var makeShowPortfolioCategory = function(category){

}




$(document).on('ready page:load', function(){
    $('[data-controller=page][data-action=index] #portfolio-tabs-wrapper').each(function(){
        var $tabs_wrapper = $(this)
        $tabs_wrapper.find('.portfolio-tab').click(function(event){
            var current_scroll_top = $(document).scrollTop()
            event.preventDefault()
            console.log('current_scroll_top: ' + current_scroll_top)


            var $tab = $(this)
            if( !$tab.hasClass('active') ){
                var $active_tab = $tabs_wrapper.find('.portfolio-tab.active')
                $active_tab.removeClass('active')
                $tab.addClass('active')

                var filter = $tab.attr('data-filter');

                PortfolioFilter(filter);



                //$(document).scrollTop(current_scroll_top)

            }
        })
    })

        $('#portfolio-index #portfolio-tabs-wrapper').each(function () {

            $tabs_wrapper = $(this);

            var handlePushStateOnPortfolioCategory = function() {
                if (!!(window.history && history.pushState)) {

                    window.onpopstate = function (event) {
                        console.log('state_data: ' + event.state)
                        state_data = event.state

                        if (state_data) {
                            STATE_DATA = state_data
                            if (state_data.controller == 'portfolio' && !!state_data.tab_id) {
                                var category_url = state_data.category
                                var tab_id = state_data.tab_id

                                //var $tab = $(".portfolio-tab.category-tab[data-category-url=" + state_data.category + "]")
                                var $tab = $tabs_wrapper.find('.portfolio-tab[data-tab-index='+ tab_id +']')

                                if (!$tab.hasClass('active')) {
                                    var $active_tab = $tabs_wrapper.find('.portfolio-tab.active')
                                    $active_tab.removeClass('active')
                                    $tab.addClass('active')

                                    var filter = $tab.attr('data-filter');

                                    //var filter = '.' + category_url;
                                    PortfolioFilter(filter);
                                }
                            }


                        }
                    }
                }
            }

            handlePushStateOnPortfolioCategory()

            //$("#all-tab").click(visualizePortfolioShowAll);

            $tabs_wrapper.find('.portfolio-tab').click(function (event) {
                event.preventDefault()
                var $tab = $(this)
                var category_url = $tab.attr('data-category-url')
                if (!$tab.hasClass('active')) {
                    var $active_tab = $tabs_wrapper.find('.portfolio-tab.active')
                    $active_tab.removeClass('active')
                    $tab.addClass('active')



                    if( !!(window.history && history.pushState) ) {

                        var tab_relative_url = $tab.attr('data-tab-relative-url')
                        var url = '/portfolio/' + tab_relative_url;
                        var state_data = { controller: 'portfolio', tab_relative_url: tab_relative_url, tab_id: $tab.attr('data-tab-index') }
                        history.pushState(state_data, '', url)


                    }
                    else{
                        if (location.pathname == '/portfolio' || location.pathname == '/portfolio/') {


                        }
                    }



                    var filter = $tab.attr('data-filter');
                    PortfolioFilter(filter);

                    //visualizePortfolioShowCategory(category_url)


                }

            })

            //$("#firm-styles-tab").click(visualizePortfolioShowFirmStyles);

            //$("#packaging-tab").click(visualizePortfolioShowPolygraphy);

            //$("#web-sites-tab").click(visualizePortfolioShowWeb);






        });



    var $active_tab = $('.portfolio-tab.active')
    var filter = $active_tab.attr('data-filter')
    console.log('filter:' + filter)
    PortfolioFilter(filter)
});