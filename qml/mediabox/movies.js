// FIXME remove the iode URLs!
// FIXME the getMovie is just a hack right now, we just re-use the same movies.json data and iterate to find the one we want, clearly that is not how we want to do it!
// FIXME when swapping views (quickly) do we have to cancel outstanding requests?

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
    console.log("Prepare GET...")
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

function getMovies() {
    console.log("[>] getMovies()")
    var req = executeGET(
        "http://www.iode.co.uk/movies.json",
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

function getMovie(mediaId) {
    console.log("[>] getMovie(mediaId=" + mediaId + ")");
    var req = executeGET(
        "http://www.iode.co.uk/movies.json#id=" + mediaId,
        function(data) {
            for (var i = 0; i < data.entries.length; i++) {
                var movie = data.entries[i].movie;
                if (movie.id === mediaId) {
                    console.log("FOUND MOVIE " + movie.id + " ->" + movie.title);
                    movie.genreNames = genres(movie.genres)
                    movieDetailView.setMovie(movie)
                    break;
                }
            }
        }
    );
    console.log("[<] getMovie()");
    return req;
}

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
