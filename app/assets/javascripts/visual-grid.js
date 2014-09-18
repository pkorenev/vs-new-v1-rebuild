$(document).on('ready page:load',function(){
	var document_height=$(document).height();
	var $body = $('body');
	var $parent=$('#main-scroller-content');
	var parent_height = $parent.height();
	var $wrapper = $('<div class="visual-grid-wrapper"></div>');
	var $grid=$('<div class="visual-grid container"></div>');
	$grid.css('height','100%');
	for(var i=1;i<=12;i++){
		var $column=$('<div class="g1"></div>');
		if(i==1){
			//$column.addClass('alpha');
		}
		if(i==12){
			//$column.addClass('omega');
		}

		$grid.append($column);
		$column.css({
			'height':'100%',
			'background-color':'rgba(0, 160, 198, 0.55)',
            'border':'1px solid rgba(0, 160, 198, 1)'
		});
	}
	$wrapper.append($grid);
	$parent.append($wrapper);
	$wrapper.css({
		'display':'none',
		'position':'fixed',
		'left':'0%',
        'right': '0%',
		'top':0,
		'z-index':100000,
		'height':'100%',
		'width':'100%',
		'background-color':'rgba(0, 160, 198, 0.15)'

	});
	$body.keypress(function(event){
		var e=event;
		if( e.which === 103 && ( e.target.tagName === 'BODY' || e.altKey === true || e.ctrlKey === true) ){
			var display=$wrapper.css('display');
			if(display === 'none'){
				$wrapper.css('display','block');
			}
			else{
				$wrapper.css('display','none');
			}
		}
	});
});
