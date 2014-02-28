
function downloadMovies() {
    console.log("[>] downloadMovies()");

    var movieReq = new XMLHttpRequest();
    console.debug("Fetching movie feed...")
    movieReq.onreadystatechange = function() {
        if (movieReq.readyState === XMLHttpRequest.DONE) {
            console.log("Movie download DONE: status = " + movieReq.status);
            if(movieReq.status === 200) {
                var json = JSON.parse(movieReq.responseText);
                for(var i=0; i<json.entries.length; i++) {
                    var movie = json.entries[i].movie;
                    movie.genreNames = genres(movie.genres);
                    model.append(movie);
                }
            }
        }
    }

    movieReq.open("GET", "http://www.iode.co.uk/movies.json");
    movieReq.send();
    console.log("[<] downloadMovies()");

}

function cancelDownloadMovie() {
    movieReq.abort();
    console.log("REQUEST ABORTED");
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
