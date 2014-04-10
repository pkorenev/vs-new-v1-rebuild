var $body = $('body');

//(function($){

    function mydraggable ( target, options) {
        var defaults = {
            max_top:25,
            min_top:0,
            reset_top:true
        };

        options = $.extend(defaults, options);

        var $draggable = target;
        var $container = $draggable.parent();

        var prev_mouse_page_y = 0;

        var state = {
            mouse_down: false,
            top:0
        };

        var onDragComplete = function(){
            if(options.reset_top && state.top > 0){
                $draggable.css('margin-top',0);
                $draggable.addClass('reset');

                var $scroller = $('#main-scroller');

                var new_scrolltop_percentage = 1 - state.top / options.max_top;

                var new_scrolltop = $scroller.scrollTop() * new_scrolltop_percentage;

                state.top = 0;

                $scroller.delay(500).animate({
                    scrollTop: new_scrolltop
                    }, 
                    {
                        easing: 'easeOutCubic',
                        duration:1500,
                        complete:function(){
                            $draggable.removeClass('reset');
                        }
                    }
                );
            }
        };

        var init = function(){

            $draggable.on('dragComplete', onDragComplete);

            $draggable.mousedown(function(){
                var $target = $(this);
                state.mouse_down = true;
                //console.log('state.mousedown:'+state.mouse_down);
                //$target.focusin();
            });

            $('body').mouseup(function(){
                console.log('body.mouseup');
                if(state.mouse_down){
                    state.mouse_down = false;
                    $draggable.trigger('dragComplete');
                }
            });

            $draggable.mouseup(function(){
                var $target = $(this);
                state.mouse_down = false;
                $draggable.trigger('dragComplete');
                //console.log('state.mousedown:'+state.mouse_down);
                //$target.focusout();
            });

            $draggable.find('img').mousedown(function(e){
                e.preventDefault();
            });

            $draggable.find('img').mousemove(function(e){
                e.preventDefault();
            });

            $draggable.mousemove(function(e){
                var $target = $(this);
                if(state.mouse_down){
                    public_event = e;
                    e.preventDefault();
                    //e.stopImmediatePropagation();
                    //console.log('mousemove');
                    var difference = e.pageY - prev_mouse_page_y;
                    prev_mouse_page_y = e.pageY;
                    state.top += difference;

                    if(state.top < options.min_top){
                        state.top = options.min_top;
                    }
                    else if(state.top > options.max_top){
                        state.top = options.max_top;
                    }

                    $target.css('margin-top',''+state.top+'px');
                    console.log('target_top:'+state.top+';mouse_Y:'+difference);
                }
                else{
                    console.log('mouse_move: not focused');
                }
            });

            $draggable.mouseout(function(){
                var $target = $(this);

                //if(state.mouse_down){   
                //    $draggable.trigger('dragComplete');
                //}
                //console.log('mouseup');
                //state.mouse_down = false;
                //$target.focusout();

            });


        };

        init();
    };
//}(jQuery));
$(document).on('ready page:load',function() {
    mydraggable($("#get-me-top"), {
        containment: "parent",
        drag: function(){
        	//var $content = $('#main-scroller-content');
        	/*$content.css({
        		top:'-100%'
        	});

        	$content.animate({
        		top:0
        	});*/

    		var $scroller = $('#main-scroller');
    		$scroller.delay(1000).animate({
    			scrollTop:0
    		}, {duration:800});

        	//$('#get-me-top').animate({'top':0});
        }
    });
});
