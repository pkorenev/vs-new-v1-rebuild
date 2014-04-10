function showPosition(location){
    var lat = location.coords.latitude;
    var lon = location.coords.longitude;
    console.info('Your current Location \n' + 'Longitude: ' + lon + '\n' + 'Latitude: ' + lat);
}

function errorMan(){
    console.error('Oops; There seems to be some problem');
}

function getCurrentPosition(){
    if(navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, errorMan);
    }
    else{
        console.error('Your browser does not support the Geo-Location feature');
    }
}
