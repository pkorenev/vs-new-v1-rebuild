var SendNotification = function(image_n, title_n, message_n, url_n) {

    if(!image_n && !title_n && !message_n && !url_n){
        // Default Notification settings
        var image_n = 'http://studiovoronin.dev/assets/notify.png';
        var title_n = 'Welcome to our page';
        var message_n = 'Some short message will be here!';
        var url_n = 'http://google.com.ua'
    }


    if (window.webkitNotifications && navigator.userAgent.indexOf("Chrome") > -1) {

        console.log("Web Notifications are supported with the WebKit API");

        if (webkitNotifications.checkPermission() == 0) {

            console.log("Web Notifications are allowed");
            var n = webkitNotifications.createNotification(image_n, title_n, message_n);

            n.close = function() {
                console.log('Redirect to article');
            };

            n.onclick = function() {
                window.focus();

                if(url_n){
                    window.open(url_n);
                }

                n.close();
            };


            n.show();

        } else if (webkitNotifications.checkPermission() == 1) {

            alert("Web Notifications are not allowed, need to ask permission");

        } else {
            console.log("Web Notifications are not allowed");
        }
    } else if (window.Notification) {

        console.log("Web Notifications are supported with the W3C/Safari API");

        if (Notification.permission === 'granted') {

            console.log("Web Notifications are allowed");
            new Notification('Notification Title', { 'body': 'Details on the notification...'});

        } else if (Notification.permission === 'default') {

            console.log("Web Notifications are not allowed, need to ask permission");

        } else {
            console.log("Web Notifications are not allowed");
        }

    } else {
        console.log("Web Notifications are not supported in this browser");
    }
};

/*
    Request permissions for web notification
 */
var CheckForNotificationsPermission = function() {
    if (window.webkitNotifications && navigator.userAgent.indexOf("Chrome") > -1) {

        console.log("Web Notifications are supported with the WebKit API");

        if (webkitNotifications.checkPermission() == 1) {
            console.log("Web Notifications are not allowed, need to ask permission");
            webkitNotifications.requestPermission();
        }

    } else if (window.Notification) {

        console.log("Web Notifications are supported with the W3C/Safari API");

        if (Notification.permission === 'default') {
            console.log("Web Notifications are not allowed, need to ask permission");
            Notification.requestPermission(function() { SendNotification(); });
        }

    } else {
        console.log("Web Notifications are not supported in this browser");
    }
};
