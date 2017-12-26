#= require components/images_upload_form
#= require components/movie_image

class MoviesJS.Pages.MoviesEdit extends MoviesJS.Lib.Page
  _initUI: ->
    new MoviesJS.Components.ImagesUploadForm(container: $('.js-images-upload-form'))

    $('.js-movie-image').each (i, image) =>
      new MoviesJS.Components.MovieImage(container: $(image))
