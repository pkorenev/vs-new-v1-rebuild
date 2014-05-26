#encoding: utf-8
module FacebookHelper

  def fc_connect
    connect = "<div id='fb-root'></div>
                <script type='text/javascript' id='facebook_connect'>(function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = '//connect.facebook.net/uk_UA/all.js#xfbml=1&appId=268725039814798';
                fjs.parentNode.insertBefore(js, fjs);
                }(document, 'script', 'facebook-jssdk'));</script>"

    connect.html_safe
  end

  def fc_like_frame
    source = '<iframe src="//www.facebook.com/plugins/like.php?href=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;width&amp;layout=button_count&amp;action=like&amp;show_faces=true&amp;share=false&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:21px;" allowTransparency="true"></iframe>'

    source.html_safe
  end

end
