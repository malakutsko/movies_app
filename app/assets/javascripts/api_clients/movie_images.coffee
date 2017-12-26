class MoviesJS.ApiClients.MovieImages extends MoviesJS.Lib.ApiClient
  @baseURL: '/movies/movie/images'

  @destroy: (imageId) ->
    @delete("/#{imageId}")
