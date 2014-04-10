/*
 * Basic jQuery Slider plug-in v.1.3
 *
 * http://www.basic-slider.com
 *
 * Authored by John Cobb
 * http://www.johncobb.name
 * @john0514
 *
 * Copyright 2011, John Cobb
 * License: GNU General Public License, version 3 (GPL-3.0)
 * http://www.opensource.org/licenses/gpl-3.0.html
 *
 */

;(function($) {

    "use strict";

    $.fn.bjqs = function(o) {
        
        // slider default settings
        var defaults        = {

            // transition valuess
            animtype        : 'fade',
            animduration    : 450,      // length of transition
            animspeed       : 4000,     // delay between transitions
            automatic       : true,     // enable/disable automatic slide rotation

            // control and marker configuration
            showcontrols    : false,     // enable/disable next + previous UI elements
            centercontrols  : true,     // vertically center controls
            nexttext        : 'Next',   // text/html inside next UI element
            prevtext        : 'Prev',   // text/html inside previous UI element
            showmarkers     : true,     // enable/disable individual slide UI markers
            centermarkers   : true,     // horizontally center markers

            // interaction values
            keyboardnav     : true,     // enable/disable keyboard navigation
            hoverpause      : true,     // enable/disable pause slides on hover

            // presentational options
            usecaptions     : true,     // enable/disable captions using img title attribute
            randomstart     : false,     // start from a random slide
            responsive      : false     // enable responsive behaviour

        };

        // create settings from defauls and user options
        var settings        = $.extend({}, defaults, o);

        // slider elements
        var $wrapper        = this,
            $slider         = $wrapper.find('ul.slider'),
            $slides         = $slider.children('.slide'),

            // control elements
            $c_wrapper      = null,
            $c_fwd          = null,
            $c_prev         = null,

            // marker elements
            $m_wrapper      = null,
            $m_markers      = null,

            // elements for slide animation
            $canvas         = null,
            $clone_first    = null,
            $clone_last     = null;

        // state management object
        var state           = {
            slidecount      : $slides.length,   // total number of slides
            animating       : false,            // bool: is transition is progress
            paused          : false,            // bool: is the slider paused
            currentslide    : 1,                // current slide being viewed (not 0 based)
            nextslide       : 0,                // slide to view next (not 0 based)
            currentindex    : 0,                // current slide being viewed (0 based)
            nextindex       : 0,                // slide to view next (0 based)
            interval        : null,              // interval for automatic rotation
            lastindex       : $slides.length - 1
        };

        var responsive      = {
            width           : null,
            height          : null,
            ratio           : null
        };

        // helpful variables
        var vars            = {
            fwd             : 'forward',
            prev            : 'previous'
        };
            
        // run through options and initialise settings
        var init = function() {

            analizeSize();
            initMarkers();
            initArrows();
            //state.currentindex = -1;
            //state.currentslide = 0;
            //showSlide(0);

            $slides.on( 'resetSlide', onResetSlide );
            $slides.on('beforeHideSlide', onBeforeHideSlide);
            $slides.on('afterHideSlide', onAfterHideSlide);
        };

        var analizeSize = function(){
            $slides.css({
                width: ''+ ( 100 / $slides.length ) +'%'
            });

            $slider.css({
                width: '' + ( 100 * $slides.length ) + '%'
            });

        };


        var resize_complete = (function () {
            
            var timers = {};
            
            return function (callback, ms, uniqueId) {
                if (!uniqueId) {
                    uniqueId = "Don't call this twice without a uniqueId";
                }
                if (timers[uniqueId]) {
                    clearTimeout (timers[uniqueId]);
                }
                timers[uniqueId] = setTimeout(callback, ms);
            };

        })();

        var conf_slide = function() {
            $wrapper.css({

            });
        };

        var conf_controls = function() {

        };

        var initMarkers = function() {
            var $markers_wrapper = $('<div class="markers-wrapper"></div>');
            var $ul = $('<ul></ul>');
            $markers_wrapper.append($ul);
            var slides_count = $slides.length;
            for(var i = 0; i<slides_count; i++){
                var $li = $('<li></li>');
                $ul.append($li);
                if(i == state.currentindex){
                    $li.addClass('active');
                }
            }
            $wrapper.append($markers_wrapper);

            $ul.find('li').click(function(){
                var $li = $(this);
                if(!$li.hasClass('active')){
                    var slideindex = $li.index();
                    showSlide( $li.index() );
                    $ul.find('li.active').removeClass('active');
                    $li.addClass('active');

                }
            });

            $('.slide').on('afterShowSlide',function(){
                var $slide = $(this);
                var slide_index = $slide.index();
                var $markers_ul = $wrapper.find('.markers-wrapper>ul');
                var $marker = $markers_wrapper.find('li').eq(slide_index);
                $marker.addClass('active');
            });

            $('.slide').on('afterHideSlide',function(){
                var $slide = $(this);
                var slide_index = $slide.index();
                var $markers_ul = $wrapper.find('.markers-wrapper>ul');
                var $marker = $markers_wrapper.find('li').eq(slide_index);
                $marker.removeClass('active');
            });
        };

        var onBeforeShowSlide = function(){

        };

        var onAfterShowSlide = function(){
            var $slide = $(this);
            $slide.removeClass('hidden-slide').addClass('visible-slide');
        };

        var onBeforeHideSlide = function(){
        
        };

        var onResetSlide = function(){
            var $slide = $(this);
            var $layers = $slide.find('.layer');
            $layers.removeClass('final-position').addClass('display-slide');
        };

        var onAfterHideSlide = function(){
            var $slide = $(this);
            $slide.removeClass('visible-slide').addClass('hidden-slide');
        };

        var initArrows = function(){
            var $arrows_wrapper = $('<ul class="arrows-wrapper"></ul>');
            var $prev = $('<li class="prev-slide"><a class="hover-area"><div class="clickable-area"><span class="arrow"></span></div></a></li>');
            var $next = $('<li class="next-slide"><a class="hover-area"><div class="clickable-area"><span class="arrow"></span></div></a></li>');
            $arrows_wrapper.append($prev);
            $arrows_wrapper.append($next);

            $prev.find('.clickable-area').click( prevSlide );
            $next.find('.clickable-area').click( nextSlide );

            $wrapper.prepend($arrows_wrapper);
        };

        var nextSlide = function(){
            var required_index = 0;
            if(state.currentindex < state.lastindex){
                required_index = state.currentindex + 1;
            }
            else{
                required_index = 0;
            }

            console.log('next:'+required_index);
            
            showSlide(required_index);
        };

        var prevSlide = function(){
            var required_index = 0;
            if(state.currentindex > 0){
                 required_index = state.currentindex - 1;
            }
            else{
                required_index = state.lastindex;
            }
            
            console.log('prev:'+required_index);

            showSlide(required_index);
        };

        var conf_keynav = function() {

        };

        var conf_hoverpause = function() {

        };  

        var conf_captions = function() {

        };

        var conf_random = function() {

        };

        var set_next = function(direction) {

        };

        

        var checkIsLoaded = function(slideIndex){
            
        };

        var showSlide = function(slideIndex) {
            console.log('showSlide: slideIndex:'+slideIndex+';lastindex:'+state.lastindex+';currentindex:'+state.currentindex);
            if(slideIndex >= 0 && slideIndex <= state.lastindex && slideIndex != state.currentindex && !state.animating){

                state.animating = true;
                $slider.trigger('beforeHideSlide');
                //console.log('displaySlide!!');
                var difference = slideIndex - state.currentindex;
                var direction = difference > 0 ? true : false;
                var currentIndex = state.currentindex;
                if( !direction ){
                    difference *= -1;
                }

                var $required_slide = $slides.eq(slideIndex);
                var $current_slide = $slides.eq(currentIndex);
                
                    $slider.animate({
                        'margin-left':( direction ? '-=100%' : '+=100%' )
                    },{
                        complete:function(){
                            difference--;
                            $current_slide.trigger('afterHideSlide');
                            $current_slide.trigger('resetSlide');

                            if(difference == 0){
                                $required_slide.trigger('afterShowSlide');
                                $required_slide.trigger('playSlideAnimation');

                                state.animating = false;        
                            }

                            if(difference > 0){
                                $slider.animate({
                                    'margin-left':'-'+(100 * slideIndex) + '%'
                                },{ 
                                    complete:function(){
                                        $required_slide.trigger('afterShowSlide');
                                        $required_slide.trigger('playSlideAnimation');

                                        state.animating = false;
                                    }
                                });
                            }
                        }
                    });
             

                

                
                
                state.currentindex = slideIndex;
                
            }
        };

        // lets get the party started :)
        init();

    };

})(jQuery);
