$(document).on('ready page:load',function(){
$('#slide2').each(function(){
	(function($){
var $slide = $('#slide-2');
var $crystal_layers = $slide.find('.layer.crystal');

var $crystal_blured_medium = $slide.find('#ii-crystal-blured-medium');
var $crystal_main = $slide.find('#ii-crystal-main');
var $crystal_medium = $slide.find('#ii-crystal-medium');
var $crystal_blured_small = $slide.find('#ii-crystal-blured-small');
var $crystal_blured_big = $slide.find('#ii-crystal-blured-big');
var $description = $slide.find('.description');


// init
$crystal_blured_medium.data('step_ratio',0.15);
$crystal_main.data('step_ratio',0.04);
$crystal_medium.data('step_ratio',0.04);
$crystal_blured_small.data('step_ratio',0.35);
$crystal_blured_big.data('step_ratio',0.3);



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

/*
$crystal_layers.mousedown(function(e){
	e.preventDefault();
	var $layer = $(this);
	$layer.addClass('selected-layer');

	var mouseToSlide = {top: e.pageY - $slide.offset().top,left: e.pageX - $slide.offset().left };
	//$layer.data('original-top',$layer.get(0).style.top);
	$layer.data('mouseToSlide',mouseToSlide);
	public_event = e;
});
*/
/*$slide.mouseup(function(){
	var $layer = $crystal_layers.filter('.selected-layer');
	$layer.removeClass('selected-layer');
});*/

/*$slide.mousemove(function(e){
	e.preventDefault();
	var $layer = $crystal_layers.filter('.selected-layer');
	if($layer.length > 0){
		
		//if(e.pageX >= $slide.offset().left && e.pageX <= $slide.offset().left + $slide.width() && e.pxgeY >= $slide.offset().top && e.pageY <= $slide.offset().top + $slide.height() ){

			var new_mouseToSlide = {top: e.pageY - $slide.offset().top,left: e.pageX - $slide.offset().left };
			var prev_mouseToSlide = $layer.data('mouseToSlide');
			var top_difference = new_mouseToSlide.top - prev_mouseToSlide.top;
			var left_difference = new_mouseToSlide.left - prev_mouseToSlide.left;	
			console.warn('left_difference:'+left_difference+'; top_difference:'+top_difference);
			$layer.css({top:(top_difference>0? '+='+top_difference : '-='+(top_difference * (-1) ) )+'px',left:(left_difference>0? '+='+left_difference : '-='+( left_difference * ( -1 ) ) )+'px'});
			$layer.data('mouseToSlide',new_mouseToSlide);
			public_difference = {top:top_difference,left:left_difference};
			public_new = {top:new_mouseToSlide.top,left:new_mouseToSlide.left};
			public_prev = {top:prev_mouseToSlide.top,left:prev_mouseToSlide.left};
		}
		//else{
		//	$layer.removeClass('selected-layer');
		//	var a = e.pageX >= $slide.offset().left;
		//	var b = e.pageX <= $slide.offset().left + $slide.width();
		//	var c = e.pxgeY >= $slide.offset().top;

		//	console.log('error: ');
		//}
	//}
});*/

	$slide.on( "playSlideAnimation", function() {
		//var $slide = $(this);

	 	/*var $description = $slide.find('#description');
	 	var description_final_left = '50%';
	 	var description_final_top = '30%';

	 	var final_data = {};
	 	$slide.find('.layer').each(function(){
	 		var $layer = $(this);
	 		var layer_left = $layer.get(0).style.left;
	 		var layer_top = $layer.get(0).style.top;
	 		//var layer_top = $layer.css('left');
	 		final_data[$layer.attr('id')] = {
	 			top:layer_top,
	 			left:layer_left
	 		};
	 	});

	 	public_final_data = final_data;
	 	$description*/

	 	//$slide.find('.layer').removeClass('final-position').addClass('display-slide').switchClass('display-slide','final-position',1000,'easeInOutQuad');

	  	




	  	$description.removeClass('final-position').addClass('display-slide');
	  	$description.switchClass('display-slide','final-position',{duration:1000,easing:'easeInOutBounce',});
	  	//$description.removeClass('display-slide').addClass('final-position');

	  	$crystal_blured_medium.removeClass('final-position').addClass('display-slide');
	  	$crystal_blured_medium.switchClass('display-slide','final-position',1000,'easeInOutQuad');
	  	//$crystal_blured_medium.removeClass('display-slide').addClass('final-position');
	  	
	  	$crystal_main.removeClass('final-position').addClass('display-slide');
	  	$crystal_main.switchClass('display-slide','final-position',1000,'easeInOutBounce');
	  	//$crystal_main.removeClass('display-slide').addClass('final-position').css('animation-name','kf').css('animation-name','slidein');
	  	
	  	$crystal_medium.removeClass('final-position').addClass('display-slide');
	  	$crystal_medium.switchClass('display-slide','final-position',1000,'easeInOutQuad');
	  	//$crystal_medium.removeClass('display-slide').addClass('final-position');
	  	
	  	$crystal_blured_small.removeClass('final-position').addClass('display-slide');
	  	$crystal_blured_small.switchClass('display-slide','final-position',1000,'easeInOutQuad');
	  	//$crystal_blured_small.removeClass('display-slide').addClass('final-position');

	  	$crystal_blured_big.removeClass('final-position').addClass('display-slide');
	  	$crystal_blured_big.switchClass('display-slide','final-position',1000,'easeInOutQuad');
	  	//$crystal_blured_big.removeClass('display-slide').addClass('final-position');


	});

	$slide.trigger('playSlideAnimation');
}(jQuery));
});

});