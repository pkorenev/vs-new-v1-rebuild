$(document).on('ready page:load',function(){
    $('#slide-czmk').each(function(){
        (function($){
            var $slide = $('#slide-czmk');
            var $crystal_layers = $slide.find('.layer.crystal');

            var $g3k_left_arrow = $slide.find('#g3k-left-arrow');
            var $czmk_monitor = $slide.find('#czmk-monitor');
            var $g3k_top_center_arrow = $slide.find('#g3k-top-center-arrow');
            var $g3k_bottom_right_arrow = $slide.find('#g3k-bottom-right-arrow');
            var $description = $slide.find('.description');
            



// init
            $czmk_monitor.data('step_ratio',0.04);




            $crystal_layers.each(function(){
                var $layer = $(this);
                var slide_offset = $slide.offset();
                var layer_offset = $layer.offset();
                var slide_height = $slide.height();
                var slide_width = $slide.width();
                var original_top = (slide_offset.top - layer_offset.top) / slide_height * 100;
                var original_left = ( slide_offset.left - layer_offset.left ) / slide_width * 100;
                var original_position = {top:original_top,left:original_left};
                $layer.data('original_position', original_position);

            });


            $slide.mousemove(function(e){
                var slide_width = $slide.width();
                var slide_center = slide_width / 2;
                var slide_offset = $slide.offset();
                var mouse_top = e.pageY - slide_offset.top;
                var mouse_left = ( e.pageX - slide_offset.left) / slide_width * 100;
                var left_difference = mouse_left - 50;
                var direction = left_difference > 0 ? true : false;
                if(left_difference<0){
                    left_difference *= -1;
                }

                $crystal_layers.each(function(){
                    var $layer = $(this);
                    var original_position = $layer.data('original_position');
                    var layer_step_ratio = $layer.data('step_ratio');
                    var margin_left = left_difference * layer_step_ratio;
                    if(margin_left>0){
                        //margin_left *= -1;
                    }
                    $layer.css('margin-left',(direction? '' : '-')+margin_left+'%');
                    //console.log('');
                });
            });



            $slide.on( "playSlideAnimation", function() {
                console.log('czmk: playSlideAnimation')
                $description.removeClass('final-position').addClass('display-slide');

                $description.delay(1000).removeClass('display-slide').addClass('final-position')
                //$description.switchClass('display-slide','final-position',{duration:3000,easing:'easeOutExpo'});
                $description.removeClass('display-slide').addClass('final-position');


                $czmk_monitor.removeClass('final-position').addClass('display-slide');
                $czmk_monitor.delay(1000).removeClass('display-slide').addClass('final-position')
                //$czmk_monitor.switchClass('display-slide','final-position',1500,'easeOutBack');
                //$czmk_monitor_arrow.removeClass('display-slide').addClass('final-position');


            });

            $slide.trigger('playSlideAnimation');

        }(jQuery));

    });

});