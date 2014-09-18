module WebfontHelper

  # Get google web font
  def load_fonts(font)
    fonts = "<script type='text/javascript'>
              WebFontConfig = {
                google: { families: [ '#{font}' ] }
              };
              (function() {
                var wf = document.createElement('script');
                wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
                  '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
                wf.type = 'text/javascript';
                wf.async = 'true';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(wf, s);
              })(); </script>"
    fonts.html_safe
  end
end
