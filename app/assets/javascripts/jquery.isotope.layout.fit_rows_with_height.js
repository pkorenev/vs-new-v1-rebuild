(function($){
  $.extend( $.Isotope.prototype, {
    _fitRowsWithHeightGetItemsPerRow : function(){
      var items_per_row = 6;

          if(window.innerWidth <= 1200 && window.innerWidth > 960){
            items_per_row = 4;
          }
          
          else if(window.innerWidth <= 960 && window.innerWidth > 600){
            items_per_row = 3;
          }

          else if(window.innerWidth <= 600){
            items_per_row = 2;
          }

          return items_per_row;
    },
  _fitRowsWithHeightReset : function() {
    this.fitRows = {
      x : 0,
      y : 0,
      height : 0
    };
  },

  _fitRowsWithHeightLayout : function( $elems ) {
    var instance = this,
        containerWidth = this.element.width(),
        props = this.fitRows;

        var items_per_row = instance._fitRowsWithHeightGetItemsPerRow();

    $elems.each( function(index) {
      var $this = $(this),
          atomW = $this.outerWidth(true),
          atomH = $this.outerHeight(true);

          //$this.css('width',Math.ceil(atomW));
          //$this.css('width',Math.ceil(atomW));

        props.x = index%items_per_row * atomW;
        props.y = Math.floor((index)/items_per_row) * atomH;

        props.x = Math.round(props.x);
        props.y = Math.round(props.y);


        //console.log('index '+index+'; props.x:'+props.x+';props.y');

        // position the atom
        instance._pushPosition( $this, props.x, props.y );

        //props.height = Math.max( props.y + atomH, props.height );
        //props.x += atomW;

      });

    /*instance.$allAtoms.each(function(index){
      var $item = $(this);
      if( $elems.filter($item).length == 1 ){
            var item_height = $item.outerHeight(true);
            var item_width = $item.outerWidth(true);
            //var items_per_row = $container.width() / item_width;
            var item_original_order = index + 1;
            //if(items){
            var item_top = Math.floor(index / items_per_row) * item_height;
            var item_left = ( index % items_per_row ) * item_width;
            //console.log('rendered for '+items_per_row+' items per row');
            props.x = item_left;
            props.y = item_top;

            instance._pushPosition($item, props.x, props.y);

            //$isotope_item.delay(750).css({top:item_top,left:item_left});

      }
    })*/
    },

    _fitRowsWithHeightGetContainerSize : function () {

      var items_per_row = this._fitRowsWithHeightGetItemsPerRow();
      console.log('layout:rendered for '+items_per_row+' items per row');


      var item = this.$filteredAtoms[0];
      var $item = $(item);

      var item_height = $item.outerHeight(true);

      var h = Math.ceil(this.$filteredAtoms.length/items_per_row) * item_height;
      h = Math.ceil(h);
      //return { height : this.fitRows.height };
      return { height : h };
    },

    _fitRowsWithHeightResizeChanged : function() {
      return true;
    },

  });
})(jQuery);