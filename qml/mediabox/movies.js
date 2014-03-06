
// FIXME when swapping views (quickly) do we have to cancel outstanding requests?
// FIXME serviceUrl will come from config, it's hard-coded right now

/**
 * Get the web-service URL.
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
 * @return XML HTTP request
 */
function executeGET(url, onSuccess) {
    console.log("[>] executeGET(url=" + url + ")");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState === XMLHttpRequest.DONE) {
            console.log("GET done with status " + req.status);
            if (req.status === 200) {
                var json = JSON.parse(req.responseText);
                onSuccess(json);
            }
        }
    }
    console.log("Execute GET (async)...")
    req.open("GET", url);
    req.send();
    console.log("[<] executeGET()");
    return req;
}

/**
 * Execute an HTTP PUT request (asynchronously).
 *
 * @param url
 * @param type FIXME for now assume text/plain for everything because that's all we need right now
 * @param body
 * @param onSuccess
 */
function executePUT(url, type, body, onSuccess) {
    console.log("[>] executePUT(url=" + url + ",type=" + type + ",body=" + body + ")");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState === XMLHttpRequest.DONE) {
            console.log("PUT done with status " + req.status);
            if (req.status === 200 || req.status === 204) { // FIXME!
                onSuccess();
            }
        }
    }
    console.log("Execute PUT (async)...")
    req.open("PUT", url);
    req.setRequestHeader("Content-Type", "text/plain");
    req.setRequestHeader("Content-Length", body.length);
    req.setRequestHeader("Connection", "close"); // FIXME why?
    req.send(body);
    console.log("[<] executePUT()");
    return req;
}

/**
 * Get the movie media catalog (asynchronously).
 */
function getMovies() {
    console.log("[>] getMovies()")
    var req = executeGET(
        serviceUrl("movies"),
        function(data) {
            for (var i = 0; i < data.entries.length; i++) {
                var movie = data.entries[i].movie;
                movie.genreNames = genres(movie.genres);
                moviesModel.append(movie);
            }
            main.state = "MOVIES";
        }
    );
    console.log("[<] getMovies()")
    return req;
}

/**
 * Get details for a particular movie (asynchronously).
 *
 * @param media media identifier
 */
function getMovie(media) {
    console.log("[>] getMovie(media=" + media + ")");
    var req = executeGET(
        serviceUrl("movies/" + media),
        function(data) {
            var movie = data.movie;
            movie.genreNames = genres(movie.genres);
            movieDetailView.setMovie(movie);
        }
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
 */
function putMedia(mediaPlayer, media) {
    console.log("[>] putMedia(mediaPlayer=" + mediaPlayer + ",media=" + media + ")");
    var req = executePUT(
        serviceUrl("player/" + mediaPlayer + "/media"),
        "text",
        media,
        function() {
            console.log("Put media succeeded");
            main.state = "MEDIA_PLAYER"
        }
    );
    console.log("[<] putMedia()");
}

/**
 * Put (i.e. set) a media player control.
 *
 * @param mediaPlayer media player identifier
 * @param type type of control to set
 * @param control control value to set
 */
function putControl(mediaPlayer, type, control) {
    console.log("[>] putControl(mediaPlayer=" + mediaPlayer + ",type=" + type + ",control=" + control + ")");
    var req = executePUT(
        serviceUrl("player/" + mediaPlayer + "/" + type),
        "text",
        control,
        function() {
            console.log("Control '" + type + "' to '" + control + "' succeeded");
        }
    );
    console.log("[<] putControl()");
}
