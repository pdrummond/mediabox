
// FIXME when swapping views (quickly) do we have to cancel outstanding requests?
// FIXME serviceUrl will come from config, it's hard-coded right now

/**
 * Get the web-service URL.
 *
 * @param requestPath
 * @return
 */
function serviceUrl(requestPath) {
    return "http://192.168.0.6:8888/mediabox/" + requestPath;
}

/**
 * Execute an HTTP GET request (asynchronously).
 *
 * @param url request URL
 * @param onSuccess success callback function
 * @param onError error callback function
 * @return XML HTTP request
 */
function executeGET(url, onSuccess, onError) {
    console.log("[>] executeGET(url=" + url + ")");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState === XMLHttpRequest.DONE) {
            if (isSuccess(req)) {
                var json = JSON.parse(req.responseText);
                onSuccess(json);
            }
            else {
                onError(req);
            }
        }
    }
    req.open("GET", url);
    req.send();
    console.log("[<] executeGET()");
    return req;
}

/**
 * Execute an HTTP PUT request (asynchronously).
 *
 * @param url request URL
 * @param type FIXME for now assume text/plain for everything because that's all we need right now
 * @param body request body to put
 * @param onSuccess success callback function
 * @param onError error callback function
 * @return XML HTTP request
 */
function executePUT(url, type, body, onSuccess, onError) {
    console.log("[>] executePUT(url=" + url + ",type=" + type + ",body=" + body + ")");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState === XMLHttpRequest.DONE) {
            if (isSuccess(req)) {
                onSuccess();
            }
            else {
                onError(req);
            }
        }
    }
    req.open("PUT", url);
    req.setRequestHeader("Content-Type", "text/plain");
    req.setRequestHeader("Content-Length", body.length);
    req.setRequestHeader("Connection", "close"); // FIXME why?
    req.send(body);
    console.log("[<] executePUT()");
    return req;
}

/**
 * Did the request complete successfully?
 *
 * @param req XML Http request
 * @return true if the requested completed successfully; otherwise false
 */
function isSuccess(req) {
    return req.status >= 200 && req.status < 300;
}

/**
 * Get the movie media catalog (asynchronously).
 *
 * @param onSuccess success callback function
 * @param onError error callback function
 * @return XML HTTP request
 */
function getMovies(onSuccess, onError) {
    console.log("[>] getMovies()")
    var req = executeGET(
        serviceUrl("movies"),
        onSuccess,
        onError
    );
    console.log("[<] getMovies()")
    return req;
}

/**
 * Get details for a particular movie (asynchronously).
 *
 * @param media media identifier
 * @param onSuccess success callback function
 * @param onError error callback function
 * @return XML HTTP request
 */
function getMovie(media, onSuccess, onError) {
    console.log("[>] getMovie(media=" + media + ")");
    var req = executeGET(
        serviceUrl("movies/" + media),
        onSuccess,
        onError
    );
    console.log("[<] getMovie()");
    return req;
}

/**
 * Format the collection of genres for display.
 *
 * @param genres array of genres
 * @return formatted genres string
 */
function genres(genres) {
    var result = '';
    for (var i = 0; i < genres.length; i++) {
        if (result.length > 0) {
            result += ', ';
        }
        result += genres[i].name;
    }
    return result;
}

/**
 * Put (i.e. set) the current media and play it.
 *
 * @param mediaPlayer media player identifier
 * @param media identifier of the media to play
 * @param onSuccess success callback function
 * @param onError error callback function
 * @return XML HTTP request
 */
function putMedia(mediaPlayer, media, onSuccess, onError) {
    console.log("[>] putMedia(mediaPlayer=" + mediaPlayer + ",media=" + media + ")");
    var req = executePUT(
        serviceUrl("player/" + mediaPlayer + "/media"),
        "text",
        media,
        onSuccess,
        onError
//        function() {
//            console.log("Put media succeeded");
//            main.state = "MEDIA_PLAYER"
//        }
    );
    console.log("[<] putMedia()");
    return req;
}

/**
 * Put (i.e. set) a media player control.
 *
 * @param mediaPlayer media player identifier
 * @param type type of control to set
 * @param control control value to set
 * @param onSuccess success callback function
 * @param onError error callback function
 * @return XML HTTP request
 */
function putControl(mediaPlayer, type, control, onSuccess, onError) {
    console.log("[>] putControl(mediaPlayer=" + mediaPlayer + ",type=" + type + ",control=" + control + ")");
    var req = executePUT(
        serviceUrl("player/" + mediaPlayer + "/" + type),
        "text",
        control,
        onSuccess,
        onError
    );
    console.log("[<] putControl()");
    return req;
}
