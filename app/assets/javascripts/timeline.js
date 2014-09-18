
(function( $ ) {
  $.fn.timeline = function(options) {
  	var options=$.extend({
        events_start:167,
  		bottom_row_event_indent:550,
        active_index:0,
        top_row_event_indent:167

  	},options);

    var $timelineWrapper=$(this);
    var $timeline=$($timelineWrapper.find('div.timeline').eq(0));
    var $events=$($timeline.find('div.event'));

    var initLines=function()
    {
        $events.each(function(eventIndex,event){
            var $event=$(event);
            //var point_left=$event.find('span.left').text();
            var event_date=$event.find('.date').text();
            
        });
    };
    function DrawLine(x1, y1, x2, y2){

    if(y1 < y2){
        var pom = y1;
        y1 = y2;
        y2 = pom;
        pom = x1;
        x1 = x2;
        x2 = pom;
    }

    var a = Math.abs(x1-x2);
    var b = Math.abs(y1-y2);
    var c;
    var sx = (x1+x2)/2 ;
    var sy = (y1+y2)/2 ;
    var width = Math.sqrt(a*a + b*b ) ;
    var x = sx - width/2;
    var y = sy;

    a = width / 2;

    c = Math.abs(sx-x);

    b = Math.sqrt(Math.abs(x1-x)*Math.abs(x1-x)+Math.abs(y1-y)*Math.abs(y1-y) );

    var cosb = (b*b - a*a - c*c) / (2*a*c);
    var rad = Math.acos(cosb);
    var deg = (rad*180)/Math.PI;

    //htmlns = "http://www.w3.org/1999/xhtml";
    //div = document.createElementNS(htmlns, "div");
    //div.setAttribute('style','border:1px solid black;width:'+width+'px;height:0px;-moz-transform:rotate('+deg+'deg);-webkit-transform:rotate('+deg+'deg);position:absolute;top:'+y+'px;left:'+x+'px;');   
        var span=$('<span></span>');
                    span.addClass('line');
                    //span.offset({top:y,left:x});
                    span.css({'top':y+'px','left':x+'px'});
                    span.height(6);
                    console.log(width);
                    span.width(width);
                    span.css('position','absolute');
                    span.css('-webkit-transform','rotate('+deg+'deg)');/* Chrome y Safari */
                    span.css('-o-transform', 'rotate('+deg+'deg)'); /* Opera */
                    span.css('-moz-transform', 'rotate('+deg+'deg)'); /* Firefox */

    $timeline.append(span);

};
    

    var initSize=function()
    {

    
    };
    var init=function(){
    	//alert($timelineWrapper.get(0).tagName);
        var timeline_width=Math.round($events.length/2)*($events.width())+Math.floor($events.length/2)*options.bottom_row_event_indent+options.events_start;
        $timeline.width(timeline_width);
        var timeline_min_left=(timeline_width-$(document).width())*(-1);
        var timeline_max_left=0;

        $timeline.find('p.description',$('div.event')).addClass('selectable');

    	$events.each(function(eventIndex,event){
    		var $event=$(event);
            $event.append('<span class="index">'+eventIndex+'</span>');
            var span=$('<span></span>');
            span.addClass('point');
            $event.append(span);

            if(eventIndex==options.active_index)
            {
                $event.addClass('active');
            }

    		if (eventIndex%2===1)
            {
    			$event.addClass('top-row');

                var event_left=Math.round(eventIndex/2) * ($event.outerWidth())+Math.floor(eventIndex/2)*options.bottom_row_event_indent+options.events_start;
                //alert(event_left);
                $event.css('left',event_left);
            }
    		else
            {
    			$event.addClass('bottom-row');

                var event_left=Math.floor(eventIndex/2) * ($event.outerWidth() + options.bottom_row_event_indent) + options.events_start;
                console.log(event_left);
                $event.css('left',event_left);
            }
    		var event_left=Math.floor(eventIndex/2)*$event.outerWidth();
            event_left+=Math.floor(event_left/2)*options.bottom_row_event_indent;
    		//if (eventIndex>0)
    		//	event_left+=options.event_indent;
            event_left+=250;
            

    		console.log(event_left);
    		//$event.css({left:event_left+'px'});

            $timeline.draggable({axis:'x',containment:[timeline_min_left,0,timeline_max_left,0],
                //start:function(event,ui){
                    //return false;
                    //helper=event;
                //},
                //handle:'div.event p.description'
                cancel:'.selectable',
                start:function(){
                    //$('.selectable').disableSelection();
                   
                   
                    /* clear selected text */
                    if (window.getSelection) {
                        if (window.getSelection().empty) {  // Chrome
                            window.getSelection().empty();
                        } else if (window.getSelection().removeAllRanges) {  // Firefox
                        window.getSelection().removeAllRanges();
                        }
                    } else if (document.selection) {  // IE?
                        document.selection.empty();
                        }
                },
                create:function(){
                    $('span.point,button,img,span.date').addClass('selectable');
                }
            });
            var draggableDiv = $timeline;
            //draggableDiv.draggable('disable');
            //$('.selectable',draggableDiv).selectable();

             draggableDiv.mousedown(function(ev) {
                mousedata=ev;
                //draggableDiv.draggable('disable');
                if(ev.button!=0) // if not left button is down
                    return;

                /* clear selected text */
                                    if (window.getSelection) {
                        if (window.getSelection().empty) {  // Chrome
                            window.getSelection().empty();
                        } else if (window.getSelection().removeAllRanges) {  // Firefox
                        window.getSelection().removeAllRanges();
                        }
                    } else if (document.selection) {  // IE?
                        document.selection.empty();
                        }
            }).mouseup(function(ev) {
            //draggableDiv.draggable('enable');
});
    });
       initLines();
       var lineWidth=6;
       var $point=$('span.point').eq(0);
        var x1=0;
        var y1=450;
        var x2=$point.parent().position().left+$point.position().left;
        var y2=$point.parent().position().top+$point.position().top;
        //x1+=$point.width()+1;
        x2+=1;
        //y1+=Math.floor(($point.height()-lineWidth)/2);
        y2+=Math.floor(($point.height()-lineWidth)/2);

console.log('exp::::'+'x1:'+x1+';y1:'+y1+';x2:'+x2+';y2:'+y2);

       DrawLine(x1,y1,x2,y2);
       //$('span.point').each(function(span,index){

//if(index>0){
    //break;
//    return;
//}
            //var $point1=;
            //DrawLine();
//       });
//alert($('span.point').length);
var points_count=$('span.point').length;
var lineWidth=6;
for(var i=0;i<points_count-1;i++){
    var point1=$('span.point').eq(i);
    var $point1=$(point1);
    var point2=$('span.point').eq(i+1);
    var $point2=$(point2);
//alert($point2.offset().top);
    var parent_x1=$point1.parent().position().left;
    var x1=$point1.parent().position().left+$point1.position().left;
    var y1=$point1.parent().position().top+$point1.position().top;
    var x2=$point2.parent().position().left+$point2.position().left;
    var y2=$point2.parent().position().top+$point2.position().top;


    x1+=$point1.width()+1;
    x2+=1;
    y1+=Math.floor(($point1.height()-lineWidth)/2);
    y2+=Math.floor(($point2.height()-lineWidth)/2);   
console.log('parent_x1:'+parent_x1+';y1:'+y1+';x2:'+x2+';y2:'+y2);
console.log('x1:'+x1+';y1:'+y1+';x2:'+x2+';y2:'+y2);

    DrawLine(x1,y1,x2,y2);
}

$('span.point,span.date,img').click(function(){
    var $point=$(this);
    var required_event=$point.parent();
    /* determine whether clicked event is currently active */
    var opened=$('.timeline .event.active span.index').text() === required_event.find('span.index').text();
    if(opened && ($(this)==$('span.point') || $(this)==$('img')))
        alert('error');
    var active_event=$('.timeline .event.active');
    active_event.animateCollapseEvent();
    active_event.removeClass('active');
    
    if(!opened)
    {
        required_event.animateExpandEvent();
        required_event.addClass('active');
    }   
    //alert(required_index);
});
/*$('span.point,span.date,img').qtip({
    content:'tooltip content',
    show:'mouseover',
    hide:'mouseout',
    position: {
    corner: {
        target:'topRight',
        tooltip: 'topRight'
      }
  },
  style: {
    name:'cream'
  } 
});*/
$('span.point,span.date,img').qtip({
content:'Розгорнути',
position: {
corner: {
target: 'topRight',
tooltip: 'bottomLeft'
}
},
style: {
name: 'cream',
padding: '7px 13px',
width: {
max: 210,
min: 0
},
tip: true
}
}); 
    };
    

init();

  };
  return this;
})( jQuery );


(function( $ ) {
  $.fn.animateExpandEvent = function(options) {
    var options=$.extend({
    },options);
    var $event=$(this);
    var active_index=-1;


public_event=$event;
if($event.hasClass('active'))
        return;
    //alert('event');
    if($event.hasClass('bottom-row'))
    {
        $event.find('img').animate({
            'top':0,
            'width':'283px',
            'height':'283px'
        },1000);
        $event.find('span.point').animate({
            'top':'-42px',
            'left':'283px'
        },1000);
        $event.find('span.date').animate({
            'top':'0',
            'left':'283px'
        },1000);
    }
    else if($event.hasClass('top-row'))
    {
        $event.find('img').animate({
            'top':0,
            'width':'283px',
            'height':'283px'
        },1000);
    }
    $event.find('span.date').animate({
            'top':'0',
            'left':'283px'
        },1000);

    //$event.focus();


  };
  return this;
})( jQuery );

(function( $ ) {
  $.fn.animateCollapseEvent = function(options) {
    var options=$.extend({
    },options);

    $event=$(this);

    //var required_index=active_index+1;
    //$event.focus();
    if(!$event.hasClass('active'))
        return;

    if($event.hasClass('bottom-row'))
    {  
        $event.find('img').animate({
            'top':'0px',
            'width':'70px',
            'height':'70px'
        },1000);
        $event.find('span.point').animate({
            'top':'-42px',
            'left':'0px'
        },1000);
        $event.find('span.date').animate({
            'top':'0',
            'left':'70px'
        },1000);

    }
    else if($event.hasClass('top-row'))
    {



        $event.find('img').animate({
            'top':'213px',
            'width':'70px',
            'height':'70px'
        },1000);
        $event.find('span.point').animate({
            'top':'290px',
            'left':'-23px'
        },1000);
        $event.find('span.date').animate({
            'top':'0',
            'left':'70px'
        },1000);
    }
  };
  return this;
})( jQuery );



(function( $ ) {
  $.fn.animateNextEvent = function(options) {
    var options=$.extend({
    },options);
    var active_index=-1;
    var $events=$('.event').each(function(eventIndex,event){
        if($event.hasClass('active'))
        {
            active_index=eventIndex;
        }
    });

if(active_index<$events.length-1)
{
    var required_index=active_index+1;
    $('.timeline .event.active').animateEvent();
    $('.timeline .event').eq(required_index).animateExpandEvent(required_index);
}

  };
  return this;
})( jQuery );

(function( $ ) {
  $.fn.animatePreviousEvent = function(options) {
    var options=$.extend({
    },options);
    var active_index=-1;
    var $events=$('.event').each(function(eventIndex,event){
        if($event.hasClass('active'))
        {
            active_index=eventIndex;
        }
    });

        if(active_index>0)
        {
        var required_index=active_index-1;

    this.animateCollapseEvent(active_index);
    this.animateExpandEvent(required_index);

}

  };
  return this;
})( jQuery );
