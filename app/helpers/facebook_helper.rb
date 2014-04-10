#encoding: utf-8
module FacebookHelper

  def fc_connect
    connect = "<div id='fb-root'></div>
                <script type='text/javascript' id='facebook_connect'>(function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = '//connect.facebook.net/ru_RU/all.js#xfbml=1&appId=268725039814798';
                fjs.parentNode.insertBefore(js, fjs);
                }(document, 'script', 'facebook-jssdk'));</script>"

    connect.html_safe
  end

end
